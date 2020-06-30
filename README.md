---
title: "Welcome to the pelotonR Package"
author: "Laura Ellis"
---


<img src="logo.png" width="160px" align="right" />

# About the Package

The pelotonR package was created to provide users with simple access to the Peloton API through R.  

The Peloton APIs are unsupported.  However, [there are some really great unofficial swagger docs](https://app.swaggerhub.com/apis/DovOps/peloton-unofficial-api/0.2.3) which I used to familiarize myself with the API.

<br/>

The package offers a set of easy to use functions which allow the user to:
	
* Pull general Peloton data in a variety of formats
* Authenticate with the Peloton API
* Pull user specific data in a variety of formats when authenticated.
* Gather full data sets in one function call without having to handle paged API calls.
* Gather joined data sets in one function call.

<br/>

# To get started:

### 1) Please install the package
<br/>
 ```
 devtools::install_github("lgellis/pelotonR")
 ```
 <br/>
 
### 2) Please check out the [pelotonR getting started guide](https://lgellis.github.io/pelotonR/)
<br/>
<a href="https://lgellis.github.io/pelotonR/">
<img src="tutorial-preview.png" width="900px" align="center" />
</a>
