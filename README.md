# Tea Subscription Service API

## Description
The Tea Subscription Service is a Rails-based backend API application that allows customers to manage their tea subscriptions. With this API, customers can easily subscribe to their favorite teas, cancel subscriptions, and view their current and past subscriptions.

## Tech Stack
- **Framework:** Ruby on Rails
- **Database:** PostgreSQL
<div align="center">
    <a href="https://www.postgresql.org/" target="_blank"><img style="margin: 10px" src="https://profilinator.rishav.dev/skills-assets/postgresql-original-wordmark.svg" alt="PostgreSQL" height="50" /></a>
    <a href="https://rubyonrails.org/" target="_blank"><img style="margin: 10px" src="https://profilinator.rishav.dev/skills-assets/rails-original-wordmark.svg" alt="Rails" height="50" /></a>
    <a href="https://www.ruby-lang.org/en/" target="_blank"><img style="margin: 10px" src="https://profilinator.rishav.dev/skills-assets/ruby-original-wordmark.svg" alt="CSS3" height="50" /></a>
</div>

## Installation
**Prerequisities:** Ruby 3.2.2, Rails 7.0.2.2, and PostgreSQL 14

**Setup**:
1. Clone repository:
```
git clone git@github.com:stackmm/tea-subscription-api.git
```
2. Navigate to root directory:
```
cd tea-subscription-service
```
3. Install gems:
```
bundle install
```
4. Setup the database:
```
rails db:{create,migrate,seed}
```
5. Start the server:
```
rails server
```
6. Visit `http://localhost:3000` to access the API endpoints

## Endpoints and JSON Contracts
#### 1. Subscribe a Customer to a Tea Subscription
```
POST /api/v1/subscriptions
```
Parameters:
- `title`: the title of the subscription
- `price`: subscription price
- `frequency`: subscription frequency (Yearly, Monthly, or Weekly)
- `customer_id`: customers's ID
- `tea_id`: tea's ID

Response:
```
{
    "data": {
        "id": "subscription_id",
        "type": "subscription",
        "attributes": {
            "title": "Subscription Title",
            "price": "Price",
            "status": "active or cancelled",
            "frequency": "Frequency",
            "customer_id": customer ID,
            "tea_id": tea ID
        }
    }
}
```
---
#### 2. Cancel a Customer's Tea Subscription
```
DELETE /api/v1/subscriptions/:subscription_id
```
Parameters:
- `subscription_id`: the ID of the subscription

Response:
```
{
    "data": {
        "id": "subscription_id",
        "type": "subscription",
        "attributes": {
            "title": "Subscription Title",
            "price": "Price",
            "status": "cancelled",
            "frequency": "Frequency",
            "customer_id": customer ID,
            "tea_id": tea ID
        }
    }
}
```
---
#### 3. View all of a Customer's Subscriptions (active and cancelled)
```
GET /api/v1/customers/:customer_id/subscriptions
```
Parameters:
- `customer_id`: the ID of the customer

Response:
```
{
    "data": [
        {
            "id": "subscription_id",
            "type": "subscription",
            "attributes": {
                "title": "Subscription Title",
                "price": "Price",
                "status": "active or cancelled",
                "frequency": "Frenquency",
                "customer_id": customer ID,
                "tea_id": tea ID
            }
        },
        {
            "id": "subscription_id",
            "type": "subscription",
            "attributes": {
                "title": "Subscription Title",
                "price": "Price",
                "status": "active or cancelled",
                "frequency": "Frenquency",
                "customer_id": customer ID,
                "tea_id": tea ID
            }
        }
    ]
}
```
---
### Contributors
Steven Stackhouse: <a href="https://github.com/stackmm">Github, <a href="https://www.linkedin.com/in/steven-stackhouse/" >LinkedIn </a>
