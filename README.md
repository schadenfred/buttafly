     _           _   _         __ _       
    | |__  _   _| |_| |_ __ _ / _| |_   _
    | '_ \| | | | __| __/ _` | |_| | | | |
    | |_) | |_| | |_| || (_| |  _| | |_| |
    |_.__/ \__,_|\__|\__\__,_|_| |_|\__, |
                                    |___/


## Getting Started

Buttafly should work fine with any Rails 5.1 app. If it doesn't work for yours, please open an issue with your rails version in it and we'll see what we can do to get you squared away. First, add Buttafly to your Gemfile:

```ruby
# Gemfile

gem 'buttafly', :git => 'git clone git@bitbucket.org:schadenfred/buttafly.git'

```

Then from the console:

```console

bundle
bin/rails generate buttafly:install
bin/rails db:migrate
bin/rails server

```

## Summary

Buttafly is a [Rails engine](http://guides.rubyonrails.org/engines.html) that bolts onto your [Ruby on Rails](http://rubyonrails.org/) application. Once installed, you can navigate to yourapp/buttafly, upload a spreadsheet, map its headers to the correct models and attributes of your application, and then import each spreadsheet row into one or more relational database records. Each record will have the correct parent and child associations. If you've made a mistake you will be able to easily to fix it.

## Example

Let's say you have a wine review application allowing reviewers to publish wine reviews and that:

1. Each winery has a winery owner and a bunch of different wines it sells, and that each wine has a unique name and vintage.
2. Each wine has a winemaker and a bunch of reviews written about that wine.
3. Each review is written by a reviewer and is about a wine.

Let's also say you've entered into an agreement with a famous wine reviewer to publish her back catalog of reviews. She isn't willing to recreate the reviews in your wine review application by hand -- because she's also a $600 an hour corporate lawyer -- but she has emailed you a spreadsheet of her reviews. The first few rows of her spreadsheet look like this:

| Winery name           | Wine name     | Vintage | Rating  | Review  |
| --------------        |---------------|--------:|-------- |---------|
| Ernie & Julio Gallows | chenin blanc  | 2009    | 82      | Egocentric yet oxymoronically fleshy Chenin Blanc. Shows bug spray, middle-aged raisin, scant pepper. Drink now through never. |
| Charles Shah          | pinot noir    | 2008    | 83      | Nearly matured and corpulent Pinot Noir. Essenses of mint, sad dog-breath, perceptable fois gras. Drink now through 2015. |
| Duckhorndog           | semillon      | 2003    | 99      | Overdressed nevertheless complex and stunning Semillon. Shows kalamata olive, hedonistic nectarine, bashful tomato. Drink now through Friday. |
| Feszter           | Gewurztraminer      | 2009    | 56      | Overdressed nevertheless sweet gewurztraminer. Shows formaldehyde, liquid death. Pour it down the drain. |

If there aren't too many rows in the spreadsheet you might email it to an intern and ask her to navigate your application's forms to create each winery the reviewer has reviewed, and then each wine that has been reviewed for that winery, and then each review for each wine from that winery. Or you might commission a $300 per hour developer to write a script to import the spreadsheet rows into your application in order to do the same thing. But what if this spreadsheet is the first of many spreadsheets from the reviewer? And what if you have many more spreadsheets from a diverse group of other famous wine reviewers, and what if each has slightly different headers and columns? And oh yeah, what if the intern or the developer screws up and corrupts your data?

Buttafly lets you metamorphose your spreadsheet data into beautiful relational db records with the correct parent and child associations.

## Dummy App Example

Let's consider the included Buttafly dummy app at buttafly/test/dummy -- which is, not coincidentally, a wine review app. Our dummy review app's model associations are declared in test/dummy/app/models, and can be condensed thusly:

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

## Running the dummy review app

Let's get that dummy review app running:

```console

git clone https://github.com/schadenfred/buttafly.git
cd buttafly
bundle
cd test/dummy
bin/rails db:setup
bin/rails server

```

Next, please navigate to [localhost:3000/buttafly](http://localhost:3000/buttafly), upload a spreadsheet, select a "targetable model" of "Review," and then create a "Legend" for the mapping. When creating the legend, you'll be asked to pair the spreadsheet header for "review content" to the Review model's "content" attribute, and the spreadsheet "rating" header to the Review model's "rating" attribute. Then because Buttafly knows each review belongs to a wine and a reviewer, it will ask you which header to pair with the Reviewer (User) model's "name" attribute, and which to pair with the Wine model's "name" attribute. And then again because it also knows each wine belongs to a winery, it will ask you which spreadsheet header to pair to the Winery "name" column and so on -- for as many ancestors as your targetable model has. Once you've imported a record, if you decide you've screwed up, you can then revert the record or even revert an entire spreadsheet mapping.

## Running tests:

```console
git clone https://github.com/schadenfred/buttafly.git
cd buttafly
bundle
cd test/dummy
bin/rails db:setup
cd ../../
bundle exec guard
```

## License

[MIT-LICENSE](http://en.wikipedia.org/wiki/MIT_License)
