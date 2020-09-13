# Recipes Drawer backend service

This application provides a REST interface to fetch recipes data from a [Contentful](https://www.contentful.com/) provider. It wraps up everything configuration-wise and provides an easy and straightforward way to access recipe's well formatted JSON data.

You can run this application standalone but it is recommended to run it along with [Recipes Drawer UI](https://github.com/uloureiro/recipes_drawer_ui), which already has this application mapped into Docker Compose and everything needed to run both the backend and the frontend.

## Configuration


This application has Docker and Docker Compose files to make it easy to get up and running.

First, clone this repo.

**Important:** It is required that you inform Contentful's credentials and configurations. The following set of variables should be informed within the `docker-compose.yml` file:

```bash
# docker-compose.yml

# ...
    environment:
      - CONTENTFUL_SPACE_ID=your_contentful_space_id
      - CONTENTFUL_ENVIRONMENT_ID=your_contentful_environment_id # usually master
      - CONTENTFUL_DELIVERY_TOKEN=your_contentful_delivery_token
      - CONTENTFUL_API_URL=contentful_url # usually cdn.contentful.com
# ...
```

Build the image running:
```bash
docker-compose build
```

Start the application running:
```bash
docker-compose up -d
```

Notes:
- This runs in dettached mode, if you want to attach output to console, remove the `-d`.
- Docker is mapping the application to `localhost:9000`, so please be sure that you don't have anything already mapped to that port.

## Fetching recipes data

### List all recipes
```bash
GET http://localhost:9000/recipes
```

### Fetch by ID
```bash
GET http://localhost:9000/recipes/{id}
```

## How to run the test suite

```bash
docker-compose run recipes_drawer_backend bundle exec rspec spec -f d
```
