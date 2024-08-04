# Marvel API Exercise

This is a project for integrating with the Marvel API, where you can query and display information about Marvel comics and characters. The project uses the public Marvel API to retrieve data and display it in a web interface.

* IMPORTANT: at the time I start this project, Marvel API was not working properly. So in order to test things out you need to comment httparty requests and uncomment mock data.

## Table of Contents

- [Description](#description)
- [Installation](#installation)
- [Usage](#usage)
- [Running Tests](#running-tests)
- [Technologies](#technologies)

## Description

This project is a web application that uses the [Marvel API](https://developer.marvel.com/) to fetch and display information about Marvel characters and comics. The application allows you to view a list of comics, mark favorites, and perform searches.

## Installation

To run this project locally, follow these steps:

1. **Clone the repository:**

   ```sh
   git clone https://github.com/guitoaraujo/marvel_comics.git
   
2. **Navigate to the project directory:**

    ```sh
    cd marvel_comics

3. **Install dependencies (assuming you are using Bundler):**
    
    ```sh
    bundle install

4. **Create and migrate the database:**
    
    ```sh
    rails db:create
    rails db:migrate

5. **Configure your environment variables:**

    ```sh
    MARVEL_PUBLIC_KEY=your_public_key_here
    MARVEL_PRIVATE_KEY=your_private_key_here

6. **Start the local server:**

    ```sh
    rails server

7. **Open your browser and go to:**

    ```sh
    http://localhost:3000


## Usage

* View Comics: Navigate to the main page to see a list of comics.
* Mark Favorites: Click the heart icon over the comic to mark it as a favorite.
* Search: Use the search bar to find comics of specific characters.

## Running Tests

This project uses RSpec for testing. To ensure that all tests pass, follow these steps:

1. **Ensure dependencies are installed:**

    ```sh
    bundle install
   
2. **Prepare the test database:**

    ```sh
    rails db:test:prepare

3. **Run the tests:**
    
    ```sh
    bundle exec rspec

4. **Check the test results:**
    
    The rspec command will display a list of all tests and their results.

## Technologies

* Frontend: HTML, CSS, JavaScript
* Backend: Ruby 3.2 & Ruby on Rails 7 (SQLite)
* API: Marvel API
* Testing: RSpec
