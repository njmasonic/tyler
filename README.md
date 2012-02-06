Tyler
=====

Tyler is a single sign on solution originally designed for the Grand Ldoge of New Jersey. Its purpose is similar to that of the tyler of a Masonic lodge. An end user can use a single credential to access multiple resources (consuming websites) while Grand Lodge maintains a single authoritize database of access credentials and can revoke access downstream when required. This is the responsibility of the Tyler SSO API.

Authorization information is populated using the Authorization API. Any number of external applications can use the Authorization API to update authorization entries that act as booth pre-registration credentials and a collection of arbitrary attributes to be shared with consuming websites. The exact attributes are defined by the Tyler administrator. Tyler does not contain anything specifically for Masons and can be used as a general purpose single sign on solution so long as Tyler's assumptions are acceptible to you.

![Sign up page](http://i.imgur.com/qLivJ.png)

Assumptions
-----------

Tyler is opinionated software. Our requirements, assumptions and opinions are:

* Consuming websites are authorized in advance and may send users to Tyler for authentication. Upon successful
  authentication Tyler will send the user back to the consuming website with a token that is used by the
  consuming website to verify the session is valid and access additional information about the user.
* User information is provided to the consuming website at the request of the user. A consuming website can
  not access user information without the user first authenticating.
* A user utilizing multiple websites that consume Tyler services they need only sign in one time.
* Passwords are never transmitted from, to or through a consuming website.
* Passwords are never stored anywhere including log files or databases. The only record of a password is saved
  in the form of a cryptographically secure hash. Consequently, users are not able to recover a lost password
  and must reset their password by verifying their e-mail address.
* A user must enter required registration information to sign up for an account. This information comes from
  an authorization that is created in advance through the authroziation API. In other words a user must be
  pre-registered. The required properties are configurable. An authorization can only be used by up to one
  user at a time.
* The Tyler Authorization API is used by other web applications to update authorization information. The
  Authorization API is independent of the Consumer API.

SSO API
-------

1. A consuming website is registered in advance with Tyler using an assigned name and return url.
2. When a consuming website requires a user to login it uses a link or HTTP redirect to send the user to
   <tt>https://tyler.yourorganization.com/sign_in?consumer=name</tt> where "tyler.yourorganization.com" is your instance
   of Tyler and "name" is the registered name of the consuming website.
3. Tyler allows the user to sign in or create an account and then redirects back to 
   <tt>http://www.consumingwebsite.com/return_url?token=abcd1234</tt> where "www.consumingwebsite.com/return_url" is the
   return url on record for the consumer and "abcd1234" is a unique token.
4. The consuming website reads the token and makes a web service HTTP GET request to
   <tt>https://tyler.yourorganization.com/validate?token=abcd1234</tt>.  If the token is valid, Tyler will return
   information about the user in JSON format, otherwise it will return HTTP 404.  The consuming website
   must validate the token within five minutes.  It is highly recommended tha the consuming website redirect
   the user to an originating URL after the token is successfully validated so that the user cannot accidentally
   hit refresh and cause an error after five minutes.
5. If a consuming website would like to give the user an opportunity to sign off they can create a link to
   <tt>https://tyler.yourorganization.com/sign_off</tt>.  This is optional.  There is no way for a consuming website to
   sign off a user directly, the request must come from the user's browser.

![SSO Process Illustration](http://i.imgur.com/89CQM.png)

Authorization API
-----------------

To be written

Setup a Tyler Server
--------------------

To be written

Setup a Development Environment
-------------------------------

To be written
