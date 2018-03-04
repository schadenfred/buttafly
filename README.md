     _           _   _         __ _       
    | |__  _   _| |_| |_ __ _ / _| |_   _
    | '_ \| | | | __| __/ _` | |_| | | | |
    | |_) | |_| | |_| || (_| |  _| | |_| |
    |_.__/ \__,_|\__|\__\__,_|_| |_|\__, |
                                    |___/


# Buttafly

Buttafly is a [Rails engine](http://guides.rubyonrails.org/engines.html). You can bolt it onto your [Ruby on Rails](http://rubyonrails.org/) application by adding it to your Gemfile and installing it with two commands. Once bolted on, it allows you to upload a spreadsheet, map its headers to the appropriate models and attributes of your application, and import each of the spreadsheets rows into one or more relational database records -- with the correct parent and child relationships. Confused? Read on.

## Example

Let us say that you have entered into an arrangement with a famous wine critic, in which she has agreed to let you publish her back catalog of reviews. Let us also say she isn't willing to recreate the reviews in your application by hand, because she is also a fancy corporate lawyer who bills at $600 an hour -- but that she is willing to provide you a spreadsheet full of her reviews, the first few rows of which look like:

| Winery name           | Wine name     | Vintage | Rating  | Review  |
| --------------        |---------------|--------:|-------- |---------|
| Ernie & Julio Gallows | chenin blanc  | 2009    | 82      | Egocentric yet oxymoronically fleshy Chenin Blanc. Shows bug spray, middle-aged raisin, scant pepper. Drink now through never. |
| Charles Shah          | pinot noir    | 2008    | 83      | Nearly matured and corpulent Pinot Noir. Essenses of mint, sad dog-breath, perceptable fois gras. Drink now through 2015. |
| Duckhorndog           | semillon      | 2003    | 99      | Overdressed nevertheless complex and stunning Semillon. Shows kalamata olive, hedonistic nectarine, bashful tomato. Drink now through Friday. |
| Feszter           | Gewurztraminer      | 2009    | 56      | Overdressed nevertheless sweet gewurztraminer. Shows formaldehyde, liquid death. Pour it down the drain. |

If there aren't too many reviews in the spreadsheet, you might be tempted to hand it off to an intern, and ask her to navigate the forms in your applicaton to create each winery, and then each wine that has been reviewed for that winery, and then each review for each wine. Alternatively you might be tempted to commission a $300 an developer to write a script to import the spreadsheet rows into your application for the same effect. But what if this spreadsheet is only the first of many spreadsheets from the reviewer? And what if you have many more spreadsheets from a diverse group of other famous wine reviewers, and what if each of these spreadsheets has slightly different headers and columns?

This is where Buttafly comes in.

Let's say that your Rails application tracks wine reviews and that:

1. Each __review__ *belongs_to* a __reviewer__ with a class_name of "User."
2. Each __review__ also belongs to a __wine__ which is the subject of the __review__.
3. Each __wine__ belongs to a __winemaker__ with a class_name of "User."
4. Each __wine__ also belongs to a __winery__ because a __winery__ will have_many wines produced under its imprimatur.
5. A __wine__ belonging to a winery may have the same name as another wine belonging to the __winery__, but it will be of a unique vintage.  
3. Each __winery__ will have one __owner__ with a class_name of "User."

So your model associations might look something like this:

# in app/models/review.rb

belongs_to :wine
belongs_to :reviewer, class_name: "User"

validates :reviewer, :wine, presence: true
```

```ruby
# in app/models/wine.rb

has_many :reviews
belongs_to :winery
belongs_to :winemaker, class_name: "User"

validates :winery, presence: true
validates_uniqueness_of :name, scope: :vintage  
```

```ruby
# in app/models/winery.rb

has_many :wines
belongs_to :owner, class_name: "User"
validates_uniqueness_of :name
```

```ruby
# in app/models/user.rb

has_many :reviews, foreign_key: :reviewer_id
has_many :wines_made, foreign_key: :winemaker_id
has_many :wineries_owned, foreign_key: :owner_id
```

So Let's also say that your wine review application is called WineOeuvre.com. Once installed with *literally* th commands, Buttafly allows you navigate to to www.wineoeuvre.com/buttafly, and upload a spreadsheet such as the one above. Because Buttafly is an engine mounted to your application, it knows through reflection about your application's models, associations, and validations. In the spreadsheet example above, you would first select a "targetable model" of "Review," and then create a "Legend." The first part of the legend would be for the review content and rating. Then because Buttafly knows each review belongs to a wine and a reviewer, it will ask you which header has the reviewer name and wine name. Because it knows each wine belongs to a winery, it will ask you for the winery name. And it also knows to ask you for the winemaker name and the owner name. Then you can click "import," and it will create the records for you, with the correct associations. It will also allow you to revert an individual record, or the entire spreadsheet import.


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
