class InitSchema < ActiveRecord::Migration[6.1]
  def change
    create_table :companies do |t|
      t.string :name, null: false
      t.string :zip_code, null: false
      t.string :prefecture, null: false
      t.string :city, null: false
      t.string :address_line_1
      t.string :address_line_2
      t.string :image_url

      t.timestamps
    end
    create_table :users do |t|
      ## Devise User

      ## Required
      t.string :provider, :null => false, :default => "email"
      t.string :uid, :null => false, :default => ""

      ## Database authenticatable
      t.string :encrypted_password, :null => false, :default => ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at
      t.boolean  :allow_password_change, :default => false

      ## Rememberable
      t.datetime :remember_created_at

      ## Confirmable
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      t.integer  :failed_attempts, :default => 0, :null => false # Only if lock strategy is :failed_attempts
      t.string   :unlock_token # Only if unlock strategy is :email or :both
      t.datetime :locked_at

      ## User Info
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.date   :birthday, null: false
      t.string :image_url
      t.string :email, null: false

      t.integer :role, null: false, default: 0, comment: "Manager, Employeeなどを区別するための項目"
      t.date   :joined_date, comment: "入社日"

      ## Tokens
      t.json :tokens

      t.references :company, foreign_key: true
      t.references :manager, foreign_key: { to_table: :users }

      t.timestamps
    end
    create_table :curriculums do |t|
      # あらかじめ作成しておくカリキュラムの骨組み
      # 一度作成しておくことでユーザーに簡単に割り当てられる仕組み
      # ユーザーの進捗に影響が出るため、AssignedCurriculumsでの割り当て後の変更はできず、
      # コピーなどで分割する必要がある(添付ファイルは追加可能)
      t.references :company, foreign_key: true, comment: "カリキュラムを登録している企業"
      t.string :name, null: false
      t.text :description

      t.timestamps
    end
    create_table :assigned_curriculums do |t|
      # ユーザーに割り当てられたカリキュラム。個別設定も記録する
      t.references :curriculum, foreign_key: true
      t.references :user, foreign_key: true, comment: "カリキュラムを割り当てられた従業員のID"
      t.datetime :start_datetime, null: false
      t.datetime :end_datetime, null: false
      t.boolean :completed, null: false, default: false

      t.timestamps
    end
    create_table :missions do |t|
      # あらかじめ作成しておくミッションの骨組み
      # 一度作成しておくことでカリキュラムに割り当てられる仕組みで、複数のカリキュラムに割り当て可能
      # ユーザーの進捗に影響が出るため、AssignedMissionでの割り当て後にミッション内容の変更はできず、
      # コピーなどで分割する必要がある(添付ファイルは追加可能)
      t.references :company, foreign_key: true, comment: "ミッションを登録している企業"
      t.string :name, null: false
      t.text :description

      t.timestamps
    end
    create_table :set_missions do |t|
      # カリキュラムに設定されたミッション
      # 1つのミッションは複数のカリキュラムに使い回すことができる仕様
      t.references :curriculum, foreign_key: true
      t.references :mission, foreign_key: true

      t.timestamps
    end
    create_table :assigned_missions do |t|
      # ユーザーに割り当てられたミッション。個別設定も記録する
      # ミッションはカリキュラムに設定されたミッション(SetMission)に紐付ける
      t.references :set_mission, foreign_key: true
      t.references :user, foreign_key: true, comment: "ミッションを割り当てられた従業員のID"
      t.datetime :start_datetime, null: false
      t.datetime :end_datetime, null: false
      t.boolean :completed, null: false, default: false

      t.timestamps
    end
    create_table :tasks do |t|
      # あらかじめ作成しておくタスクの骨組み
      # 一度作成しておくことでミッションに割り当てられる仕組みで、複数のミッションに割り当て可能
      # ユーザーの進捗に影響が出るため、AssignedTaskでの割り当て後にタスク内容の変更はできず、
      # コピーなどで分割する必要がある。(添付ファイルは追加可能)
      t.references :company, foreign_key: true, comment: "タスクを登録している企業"
      t.string :name, null: false
      t.text :description
      t.boolean :must_be_submitted, null: false, default: false

      t.timestamps
    end
    create_table :set_tasks do |t|
      # ミッションに設定されたタスク
      # 1つのタスクは複数のミッションに使い回すことができる仕様
      t.references :mission, foreign_key: true
      t.references :task, foreign_key: true

      t.timestamps
    end
    create_table :assigned_tasks do |t|
      # ユーザーに割り当てられたタスク。個別設定も記録する。
      # タスクはミッションに設定されたタスク(SetTask)に紐付ける
      t.references :set_task, foreign_key: true
      t.references :user, foreign_key: true, comment: "タスクを割り当てられた従業員のID"
      t.datetime :start_datetime, null: false
      t.datetime :end_datetime, null: false
      t.boolean :completed, null: false, default: false

      t.timestamps
    end
    create_table :comments do |t|
      t.references :assigned_task, foreign_key: true
      t.references :user, foreign_key: true, comment: "コメントをするユーザーのID"
      t.text :content, null: false

      t.timestamps
    end
    create_table :skills do |t|
      t.references :company, foreign_key: true, comment: "スキルを登録している企業"
      t.string :name, null: false
      t.text :description

      t.timestamps
    end
    create_table :skill_points do |t|
      t.references :mission, foreign_key: true, comment: "スキルポイントを獲得できるミッションのID"
      t.references :skill, foreign_key: true
      t.integer :point, null: false, default: 0, comment: "そのミッションを通じて獲得できるスキルのポイント"

      t.timestamps
    end
    create_table :owned_skills do |t|
      t.references :user, foreign_key: true, comment: "スキルを所有しているユーザーのID"
      t.references :skill, foreign_key: true
      t.integer :point, null: false, default: 0, comment: "スキルの習得率 0〜100点"

      t.timestamps
    end
    create_table :attachments do |t|
      t.references :source, polymorphic: true, comment: "Task, Commentなど複数で利用"
      t.string :name, null: false
      t.string :url, null: false

      t.timestamps
    end

    add_index :users, :email,                unique: true
    add_index :users, [:uid, :provider],     unique: true
    add_index :users, :reset_password_token, unique: true
    add_index :users, :confirmation_token,   unique: true
    add_index :users, :unlock_token,         unique: true
  end
end
