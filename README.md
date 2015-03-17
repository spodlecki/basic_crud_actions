# Basic CRUD Actions
[![Code Climate](https://codeclimate.com/github/STCTbone/basic_crud_actions/badges/gpa.svg)](https://codeclimate.com/github/STCTbone/basic_crud_actions)

## Overview
Basic CRUD Actions adds your standard Create, Read, Update, and Destroy functions with a single line of code in your controller.
Just add `acts_as_crud` at the top of your controller definition, and you will have standard instance variables, doing the
standard things you expect of them for each action.

## Compatibility

* Rails 3.2.x+
* Ruby 1.9.3+

## What The Actions Do
Instance variables (except for `index`) provided are named after the controller's model in snake case form.
E.g MyModel creates an instance variable named @my_model.
### Create

* it expects you to define 'create_params' in your model. This should be a standard strong-params private function in
Rails 4.0+, or simply a function that returns the subset of the params hash you need, e.g.:


    def create_params
      params[:my_model_name]
    end

* it creates a new instance of the model, then calls `.save` on it.
* it provides an instance variable of your new model
* it sets a success or error hash, based on whether `.save` succeeds.

### Destroy
* it expects params[:id] to have the id of the model
* it destroys the model
* it redirects to the index page for the model

### Edit
* it expects params[:id] to have the id of the model
* it provides the requested instance of the model as an instance variable

### Index
* it provides the entire collection for your model; the instance variable is pluralized

### New
* it provides a new, blank instance of the model

### Update
* it expects params[:id] to have the id of the model
* it expects you to define 'update_params' in your model. This works just like create_params above,
 and if your allowed parameters for Update are the same as create, you can simply write


    def update_params
      create_params
    end[^or-alias]

* it calls `.update_attributes` on the model
* it provides an instance variable of your updated model
* it sets a success or error hash, based on whether `.update` succeeds.
* it redirects to the edit page for the updated model instance, regardless of success or failure.

## Options
You can customize Basic CRUD Actions' behavior using the following hash keys, passed as an argument
to `acts_as_crud`

* `model:` sets a custom model for flashes, instance variables, etc. Pass in the class itself, not an instant or string
 of the name
* 'model-name:' sets a custom name
* `only:` takes an array of symbols for which CRUD actions you want added to this controller
options are `:create, :update, :new, :index, :edit, :destroy`. Ex: `acts_as_crud only: [:create, :update]`
* `except:` takes an array of symbols for which CRUD actions you do **not** want to add to
this controller. All other actions will be added. Options are `:create, :update, :new, :index, :edit, :destroy`.
Ex: `acts_as_crud except: [:destroy, :update]`

## Customization
Basic CRUD Actions is modular, meaning you can pick and choose the components to use versus override.
You can override any of the controller actions underneath the `acts_as_crud` declaration, and invoke the standard
`acts_as_crud` behavior by invoking `super`. Other overridable functions include

### `find_model`
Normally calls `model_source` with params[:id}

### `instance_variable_name`
This usually returns "@#{class_name.underscore}", but by overriding it you can set the name of your instance variables
to whatever you want.


### `model_source`
Normally returns the method `#find` for the model. This should return a callable method, but other than that feel free
to do whatever ordering, filtering, etc. you want.

### `models_source`
Normally returns the method `#all` for the model. This should return a callable method, but other than that feel free
to do whatever ordering, filtering, etc. you want.

### `new_model_source`
Normally returns the method `#new` for the model.

## Filtering
`acts_as_crud` also adds a `.filter` method to ActiveRecord::Relation: this takes either a block or a hash of arguments.
If you supply a hash, it will filter by `where(key => val)` for each key in the hash. You can filter using whatever
methods you want if you supply a block.


## Shared Examples

There are shared examples for each of the basic_crud actions, plus for flashes if you just want to test those are
being properly set. The shared examples are automatically added and ready to go in the gem, here's the list:

* `basic_crud success flashes`
* `basic_crud failure flashes`
* `basic_crud create`
* `basic_crud destroy`
* `basic_crud edit`
* `basic_crud index`
* `basic_crud new`
* `basic_crud update`
* `find_model`

In order to use the examples you need to create a subject block
containing a standard example of the controller call, e.g, `subject { get :index } ` and
for the `.update` action only, a `let(:model)` statement with its block a the sample model you want to work with.

[^or-alias]: Or alias create_params, your call.
