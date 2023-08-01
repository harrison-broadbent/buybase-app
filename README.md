# Buybase — Sell access to your Airtable or Notion

View the website — https://buybase.io

> Note: The main app isn't running anymore, just the marketing website

## Features
- Uses the Stripe API gem to handle payments via Stripe Connect (see app/models/dataset.rb)
  - Uses Stripe Connect to handle payments between customers and sellers, with Buybase taking a 5% fee from all transactions
- Product page analytics, so sellers can see statistics on their products
- Gated access to datasets, protected via unique access codes (generated with the `haikunator` gem)
- Access code management, so sellers can directly add or remove access codes from their datasets

## Running locally
- If you happen to be an interested EM from HotDoc, it might be fun to try running Buybase locally.
- The `bin/dev` script should handle most things — just run `bin/dev` and the web app and css server will start.
  - If you're really interested, I wrote more about `bin/dev` and `foreman` here — https://railsnotes.xyz/blog/procfile-bin-dev-rails7  
- You also should run `rails db:create` and `rails db:migrate` to set up the database correctly (there are no seeds to run).
- To test the payments flow, you'll also need to add a Stripe :api_key into your Rails credentials with `rails credentials:edit`, such that we can access it with `Rails.application.credentials.stripe[:api_key]`.
- (There might be more... I worked on Buybase earlier this year, but have since been working on other things, namely RailsNotes).
- **Note:** unfortunately, when you do get the app running, you wont be able to login — the Google Oauth setup isn't working anymore. But you can comment out the `before_action authenticate_user!` in the home and dataset controllers to see this —

<img width="1338" alt="Screenshot 2023-07-27 at 5 06 58 pm" src="https://github.com/harrison-broadbent/buybase-app/assets/5293153/543d4cef-f4f3-451b-b321-81753fa61fed">
