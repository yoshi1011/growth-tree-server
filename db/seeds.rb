owned_skill_range = (1..5).map { |i| i * 10 }
skill_point_range = (2..8).map { |i| i * 10 }

10.times.each do |n|
  # 企業・マネージャーの追加
  company = Company.create!(name: "株式会社#{n}", zip_code: "0000000", prefecture: "東京都", city: "港区")
  manager = company.users.build(
    email: "manager_#{n}@example.com", password: "password", first_name: "山田#{n}", last_name: "太郎#{n}",
    birthday: Date.today - [*10000..30000].sample.days, role: "manager", company_id: company.id
  )
  manager.skip_confirmation!
  manager.save!

  # カリキュラムを作成する
  company.curriculums.create!(
    name: "Ruby on RailsでWebアプリケーションを開発できるようになる_#{n}",
    description: "Ruby on Railsを使って開発ができるようになり、会社の戦力になろう"
  )
  company.curriculums.create!(
    name: "Flutterでモバイルアプリケーションを開発できるようになる_#{n}",
    description: "Flutterを使って開発ができるようになり、会社の戦力になろう"
  )
  company.curriculums.create!(
    name: "業務でAWSインフラ構築ができるようになる_#{n}",
    description: "AWSインフラ構築ができるようになり、サービスをユーザーに使ってもらえるようになろう"
  )

  # ミッションを作成する
  company.missions.create!(
    name: "チェリー本を読了する",
    description: "伊藤先生のRuby本を読んでRubyの基礎を身に着けよう"
  )
  company.missions.create!(
    name: "Railsチュートリアルを完了する",
    description: "SNSクローンアプリの開発を通じてRuby on Railsの基礎を身に着けよう"
  )
  company.missions.create!(
    name: "MDN Web DocsでJavaScript入門編をやり抜く",
    description: "JavaScriptの基礎を身に着けよう"
  )
  company.missions.create!(
    name: "Flutterチュートリアルをクリアする",
    description: "Flutterの基礎を身に着けよう"
  )

  # タスクを作成する
  15.times.each do |nn|
    company.tasks.create!(
      name: "#{nn}を実施する", description: "#{nn}を実施することでスキルを高める", must_be_submitted: nn % 2 == 0
    )
  end

  # スキルを作成する
  company.skills.create!(name: "Ruby", description: "Rubyです")
  company.skills.create!(name: "Ruby on Rails", description: "Ruby on Railsです")
  company.skills.create!(name: "JavaScript", description: "JavaScriptです")
  company.skills.create!(name: "Flutter", description: "Flutterです")
  # あえてdescription書かない
  company.skills.create!(name: "React", description: "")

  # カリキュラムにミッションを登録
  company.curriculums.each do |curriculum|
    company.missions.sample(n % 3 + 1).each do |mission|
      curriculum.set_missions.create!(mission_id: mission.id)
    end
  end

  # ミッションにタスク、達成スキルポイントを登録する
  company.missions.each do |mission|
    company.tasks.sample(n % 3 + 1).each do |task|
      mission.set_tasks.create!(task_id: task.id)
    end

    company.skills.sample(n % 3 + 1).each do |skill|
      mission.skill_points.create!(
        skill_id: skill.id,
        point: skill_point_range.sample
      )
    end
  end

  # 従業員を作成し、所有スキルの登録、カリキュラムなどの登録を行う
  [*3..10].sample.times.each do |nn|
    employee = company.users.build(
      email: "user_#{n}_#{nn}@example.com", password: "password", first_name: "田中#{nn}", last_name: "一郎#{nn}",
      birthday: Date.today - [*9000..15000].sample.days, role: "employee", company_id: company.id, manager_id: manager.id
    )
    employee.skip_confirmation!
    employee.save!

    # 1〜3つのスキルをランダムで取得する
    company.skills.sample(n % 3 + 1).each do |skill|
      employee.owned_skills.create!(
        skill_id: skill.id,
        point: owned_skill_range.sample
      )
    end

    # 90%の確率でユーザーにカリキュラムをアサインする
    if rand(1..10) > 1
      curriculum = company.curriculums.sample
      start_datetime = DateTime.now - [*10..50].sample.days
      end_datetime = start_datetime + [*3..12].sample.months
      employee.assigned_curriculums.create!(
        curriculum_id: curriculum.id, start_datetime: start_datetime, end_datetime: end_datetime
      )

      # カリキュラムにセットされたミッションをアサインする
      curriculum.set_missions.each_with_index do |set_mission, mission_index|
        mission_start = start_datetime + mission_index.months
        mission_end = start_datetime + (mission_index + 1).months - 1.days
        employee.assigned_missions.create!(
          set_mission_id: set_mission.id,
          start_datetime: mission_start,
          end_datetime: mission_end
        )

        # さらにミッションにセットされたタスクをアサインする
        set_mission.mission.set_tasks.each_with_index do |set_task, task_index|
          task_start = mission_start + (task_index * 3).days
          task_end = mission_start + (task_index * 3 + 3).days
          assigned_task = employee.assigned_tasks.create!(
            set_task_id: set_task.id,
            start_datetime: task_start,
            end_datetime: task_end
          )
          if rand(1..10) > 5
            assigned_task.comments.create!(
              user_id: employee.id,
              content: "提出しました"
            )
            assigned_task.comments.create!(
              user_id: manager.id,
              content: "確認しました"
            )
          end
        end
      end
    end
  end
end

