# README

To run app locally or run Rspec tests:

1. create an account and get your APP_ID and SECRET keys as described in this guide:
https://docs.saltedge.com/guides/quick_start/

2. create `.env` file and put keys in it:
```
SALTEDGE_APP_ID=YOUR_APP_ID
SALTEDGE_SECRET=YOUR_APP_SECRET
```

&nbsp;

Run app:
```
bunble exec rails server
```

&nbsp;

Run Rspec tests:
```
bunble exec rspec
```
