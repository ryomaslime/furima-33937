## usersテーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| nickname   | string | null: false|
| email  | string | null: false, unique: true|
| encrypted_password   | string | null: false|
| first_name   | string | null: false|
| first_name_reading  | string | null: false|
| last_name   | string | null: false|
| last_name_reading  | string | null: false|
| birthday | date | null: false|


### Association
- has_many :items
- has_many :purchases


## itemsテーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| item_name  | string | null: false|
| item_explanation   | text | null: false|
| category_id  | integer | null: false|
| state_id  | integer | null: false|
| delivery_fee_id  | integer | null: false|
| area_id  | integer | null: false|
| duration_id  | integer | null: false|
| price  | integer | null: false|
| user | references | null: false, foreign_key: true|

### Association
- belongs_to :user
- has_one :purchase


## purchasesテーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| user   | references | null: false, foreign_key: true|
| item  | references | null: false, foreign_key: true|

### Association
- belongs_to :user
- belongs_to :item
- has_one :address


## addressesテーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| postal_code   | string | null: false|
| area_id  | integer | null: false|
| city  | string | null: false|
| house_number  | string | null: false|
| building_name  | string |
| telephone | string | null: false|
| purchase | references | null: false, foreign_key: true|

### Association
- belongs_to :purchase