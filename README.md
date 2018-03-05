     _           _   _         __ _       
    | |__  _   _| |_| |_ __ _ / _| |_   _
    | '_ \| | | | __| __/ _` | |_| | | | |
    | |_) | |_| | |_| || (_| |  _| | |_| |
    |_.__/ \__,_|\__|\__\__,_|_| |_|\__, |
                                    |___/


# Buttafly

Buttafly is a [Rails engine](http://guides.rubyonrails.org/engines.html). You can bolt it onto your [Ruby on Rails](http://rubyonrails.org/) application by adding it to your Gemfile and installing it with two commands. Once bolted on, Buttafly allows you to navigate to www.yourapp.com/buttafly, upload a spreadsheet, map its headers to the correct models and attributes of your application, and then import each of the spreadsheet's rows into one or more relational database records -- each record with the correct parent and child associations. Confused? Read on.

## Use case

Let's say that you've entered into an agreement with a famous wine critic. Under the agreement, she has agreed to let you publish her back catalog of reviews. Let's also say she isn't willing to recreate the reviews in your wine review application by hand -- because she's also a corporate lawyer who bills at $600 an hour -- but that she is willing to provide you with spreadsheets of her reviews. And let's also say that the first few rows of one of the spreadsheets looks like this:

| Winery name           | Wine name     | Vintage | Rating  | Review  |
| --------------        |---------------|--------:|-------- |---------|
| Ernie & Julio Gallows | chenin blanc  | 2009    | 82      | Egocentric yet oxymoronically fleshy Chenin Blanc. Shows bug spray, middle-aged raisin, scant pepper. Drink now through never. |
| Charles Shah          | pinot noir    | 2008    | 83      | Nearly matured and corpulent Pinot Noir. Essenses of mint, sad dog-breath, perceptable fois gras. Drink now through 2015. |
| Duckhorndog           | semillon      | 2003    | 99      | Overdressed nevertheless complex and stunning Semillon. Shows kalamata olive, hedonistic nectarine, bashful tomato. Drink now through Friday. |
| Feszter           | Gewurztraminer      | 2009    | 56      | Overdressed nevertheless sweet gewurztraminer. Shows formaldehyde, liquid death. Pour it down the drain. |

If there aren't too many reviews in the spreadsheet you might be tempted to email the spreadsheet to an intern and ask her to navigate your applicaton's forms to create each winery that has been reviewed, and then each wine that has been reviewed for that winery, and then each review for each wine from that winery. Or you might commission a $300 an developer to write a script to import the spreadsheet rows into your application for the same effect. But what if this spreadsheet is only the first of many spreadsheets from the reviewer? And what if you have many more spreadsheets from a diverse group of other famous wine reviewers and each of these spreadsheets has slightly different headers and columns?

Buttafly lets you -- as well as any non-technical person -- metamorphose your spreadsheet data into beautiful relational db records.

## Dummy App Example

Let's consider our dummy app at buttafly/test/dummy, which is a wine review application that allows reviewers to publish wine reviews:

1. Each winery has a winery owner and a bunch of wines it sells, each with its own name and vintage.
2. Each wine has a winemaker and has a bunch of reviews written about it.
3. Each review is written by a reviewer and is about a wine.

Our model associations are declared in test/dummy/app/models and can be condensed thusly:

```ruby

# app/models/review.rb

belongs_to :wine
belongs_to :reviewer, class_name: "User"

validates :reviewer, :wine, presence: true

# app/models/wine.rb

has_many :reviews
belongs_to :winery
belongs_to :winemaker, class_name: "User"

validates :winery, presence: true
validates_uniqueness_of :name, scope: :vintage  

# app/models/winery.rb

has_many :wines
belongs_to :owner, class_name: "User"
validates_uniqueness_of :name

# in app/models/user.rb

has_many :reviews, foreign_key: :reviewer_id
has_many :wines_made, foreign_key: :winemaker_id
has_many :wineries_owned, foreign_key: :owner_id

```

Once installed Buttafly knows through rails reflection about your application's models, associations, and validations. In the spreadsheet example above, you would first select a "targetable model" of "Review," and then create a "Legend." When creating the legend, you will be asked to pair the header for the "review content" to the Review model's "content" attribute, and the "rating" header to the Review model's "rating" attribute. Then because Buttafly knows each review belongs to a wine and a reviewer, it will ask you which header to pair with the Reviewer (User) model's "name" attribute, and to the Wine model's "name" attribute. And because it knows each wine belongs to a winery, it will ask you which header to pair to the Winery "name" column and so on, for as many ancestors as your targetable model has. Once you've imported a record, you can then revert the record to its initial state, or revert an entire spreadsheet mapping.

If you'd like to see buttafly at work in the dummy app described above, add it to the Gemfile of your app or clone this repository, cd into test/dummy, and from the console do:

```console

bundle
bin/rails g buttafly:install
bin/rails db:setup

```

Then [localhost:3000](localhost:3000).

If you'd like to try it out on your own app, just add to your Gemfile.

## Getting Started

Add buttafly to your Gemfile:

```ruby
gem 'buttafly'
```

Then:

```console
bin/rails g buttafly:install
rake db:migrate
```
Then [localhost:3000/buttafly](localhost:3000/buttafly).

## Tests

After cloning the application, bundling its gems, and migrating the database, you can run your tests with guard from the root of the engine itself:

```console
bundle exec guard
```
To see buttafly running from a dummy app,

```console
cd /buttafly/test/dummy
bundle exec rails s
```
## License



[MIT-LICENSE](http://en.wikip edia.org/wiki/MIT_License)
