# Change Log
## 15.3.0
**Implemented enhancements**
- Added [jQueryBootstrapValidation](https://reactiveraven.github.io/jqBootstrapValidation/)
for front end validations.
- Added Rails model validations at local DB for patient model.

## 15.2.4
**Fixed bugs**
- Fixed root page to show disclaimer rather than form.

**Major chore**
- Added CHANGELOG to repo.

## 15.2.3
**Added payment email admin notification**
- Added another mailer for on payment environment to be sent to ADMIN_EMAIL.

## 15.2.2
**Minor Cleanup**
- Removed home controller

## 15.2.1
**Fixed bugs**
- Fixed ajax not incrementing form #.

## 15.2.0
**Minor chore**
- Removed landing page and kept root page as form page.

## 15.1.0
**Added SendGrid email functionality**
- Allows sending html email on new user sign up to ADMIN_EMAIL.

## 15.0.0
**Added separate payments table**
- Added one to many association between patient and payments.

**Implemented enhancements**
- Shorted transaction ID: Allows ID to contain timestamp values.

**Fixed bugs**
- Various bug fixes for payment gateways.

## 14.2.2
**Moved embedded js to coffeescript file**
- Allows better handling of ajax request dependency.

## 14.1.2
**Fixed bugs:**
- Fixed http response status and handling.
- Fixed patient creation API call error.

**Implemented enhancements**
- Used a multistage check on local and remote DB. The local DB is now always in sync with remote DB. See [commit](https://bitbucket.org/ranjitishaan/remedica-patient/commits/ cfbe5409ccd6945cf8f60c3e5343b661a9d8bea3?at=master)

## 14.0.1
**Added patient lookup and creation API calls.**
- Provides better flexibility. The API call receiving side is
updated with API controllers.
- Added mail support setup.

## 13.1.1
**Added payment detail columns to patient table**

## 13.0.1
**Fixed payment gateway checksum mismatch**

## v13.0.0
**Added PayU Biz payment integration**
- For future reference, just use API calls. ActiveMerchant and/or any other ruby libraries are either outdated or insecure.

## v12.3.1
**Fixed Typeform responsive behaviour on all screen sizes.**

## v12.3.0
**Embedded Real Typeforms and rendered according to condition.**
- Patient CRUD operations setup under /admin/patient.
- Admin access implemented with simple Auth.
- Payment Gateway Mock setup.

## v12.2.0
**Embedded dummy Typeform into app**
- Dummy Typeform embedded using full screen iframe.

## v12.1.0

**Integrated static files into Rails 5.**
- Static files moved to assets/
- All image, js and css references switched to erb references.
