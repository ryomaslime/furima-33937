## usersテーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| nickname   | string | null: false|
| email  | string | null: false|
| password   | string | null: false|
| password_confirmation  | string | null: false|
| user_name   | string | null: false|
| user_name_reading  | string | null: false|
| birthday_year_id   | integer | null: false|
| birthday_month_id  | integer | null: false|
| birthday_date_id  | integer | null: false|

### Association
- has_many :items
- has_one :purchase


## itemsテーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| image   | string | null: false|
| item_name  | string | null: false|
| item_explanation   | text | null: false|
| category_id  | integer | null: false|
| state_id  | integer | null: false|
| delivery_fee_id  | integer | null: false|
| area_id  | integer | null: false|
| duration_id  | integer | null: false|
| price  | integer | null: false|
| user | references | null: false| foreign_key: true|

### Association
- belongs_to :user
- has_one :purchase


## purchasesテーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| user   | references | null: false| foreign_key: true|
| item  | references | null: false| foreign_key: true|

### Association
- belongs_to :user
- belongs_to :item
- has_one :address


## addressesテーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| postal_code   | string | null: false| foreign_key: true|
| prefecture_id  | integer | null: false| foreign_key: true|
| city  | string | null: false|
| house_number  | string | null: false|
| building_name  | string | null: false|
| telephone | string | null: false|
| purchase | references | null: false| foreign_key: true|

### Association
- belongs_to :user
- belongs_to :item
- belongs_to :purchase