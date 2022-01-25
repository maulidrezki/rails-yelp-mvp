Background & Objectives
The objective of this challenge is to build a two-model Rails app with a restaurant and anonymous reviews. You can refer to the Rails guide for a similar example using articles and comments.

Validation
A restaurant must have a name, an address and a category.
A restaurant's category must belong to this fixed list: ["chinese", "italian", "japanese", "french", "belgian"].
When a restaurant is destroyed, all of its reviews must be destroyed as well.
A review must belong to a restaurant.
A review must have content and a rating.
A review's rating must be a number between 0 and 5.
Validate all model tests before moving to the routing layer

Seed
Seed your restaurant database in db/seeds.rb with at least 5 valid restaurant records.
Run rails db:seed to launch the seeding script.
Routing / Controllers
Asking yourself what routes you need is a very important step in your web-app building process. Routes should exactly mirror your product's user stories. So let's define our minimal product here:

A visitor can see the list of all restaurants.
GET "restaurants"
A visitor can add a new restaurant, and be redirected to the show view of that new restaurant.
GET "restaurants/new"
POST "restaurants"
A visitor can see the details of a restaurant, with all the reviews related to the restaurant.
GET "restaurants/38"
A visitor can add a new review to a restaurant
GET "restaurants/38/reviews/new"
POST "restaurants/38/reviews"
And that's it!
In our MVP, a visitor cannot update / delete any restaurant or review. This is the role of the admin (i.e. you) - as a developer you have the power to manipulate the DB from the rails console if you want to update / delete any record.

We know it's a pretty basic MVP, but we just need you to understand that each route is the embodiment of a user-story. Don't just blindly write 7 CRUD routes for every model in your app. It's the best way to get confused by your own product and forget what your MVP really is.

Now, it's time to implement all the routes you need to build this product!

Hint: to handle the route GET "restaurants/38/reviews/new", you will have to use nested resources.

Views
Let's turn our attention to frontend, because that is what our users are going to see! Follow this guide to set up your Rails frontend if you haven't done it at the beginning of the challenge (⚠️ only do the setup section, don't try to implement Bootstrap JS, we will cover that tomorrow!).

Layout / partials
Remember to refactor your views using layouts and partials. For example:

The applicaton layout can include a Bootstrap navbar with links to the list of restaurants and to the restaurant creation form.
Forms can be placed in a partial to make your HTML more readable.
Helpers
When using a Rails helper like link_to, you can pass it a hash of HTML attributes. This allows you to add Bootstrap CSS classes to your links. Example below:

link_to
<%= link_to "See details", restaurant_path(restaurant), class: "btn btn-primary"%>
This generates the following HTML:

<a href="/restaurants/3" class="btn btn-primary">See details</a>
form_for
Be careful though - your reviews URLs are now nested in /restaurants/:restaurant_id. This means you can't use form_for the same way you did with a non-nested resource. If you write:

<%= form_for(@review) do |f| %>
  <!-- [...] -->
<% end %>
It will generate this HTML:

<form action="/reviews">
  <!-- [...] -->
</form>
That's not what we want because we don't have a route for POST "reviews". Instead, you will have to use the nested resource syntax for form_for:

<%= form_for [@restaurant, @review] do |f| %>
  <!-- [...] -->
<% end %>
This will generate the following HTML form:

<form action="/restaurants/42/reviews">
  <!-- [...] -->
</form>
This URL is now consistent with the route POST "restaurants/:restaurant_id/reviews" you have defined in routes.rb. Yeah! For a bit more info on this, have a read of this post.

Hint: Install the simple_form gem to get bootstrap-compatible forms with a lighter syntax.

Improve your app
Once you have finished the first version of your resto-review app, try to improve it by embedding your review form inside each restaurant's show view. This means your new routing will look like this:

GET "restaurants"
GET "restaurants/new"
GET "restaurants/38"
POST "restaurants"
POST "restaurants/38/reviews"
Notice that we got rid of the route GET "restaurants/38/reviews/new". This is because the review form is now embedded in the restaurants/show.html.erb view. 🛏

To run the appropriate tests for this version, run the command rspec -t refactoring.
