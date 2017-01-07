# Change Log
##17.4.0
**UI Refactor**
- Added FontAwesome spinner before TypeForm loads.
- Removed payment options button and put in single
  'Pay Now' button.
- Removed mode value setting based on button clicked
  to accomodate the above change.

##17.3.0
**Refactor**
- Added PayU 'unmappedstatus' param to error message
  to allow more information on pay status. This contains
  user specific actions that caused success/failure
  while 'error_msg' contains PG specific actions.

##17.2.0
**Hotfix**
- Add mode to user_payment_params, fixes ActiveRecord
  validation error in prod env.


## 17.1.0
**Major fixes**
- Removed mode attr presence validation to allow payments
  search by txnid.

**Refactor**
- fixed user session persisting after payment by
  setting @current_user to nil after update_payment.
- added payment status update after failure/success

## 17.0.0
**Major fixes : PayU PG working**
- Removed mode specific redirection based on
  appending IDs to the location.
- This *fixed PayU prod error*.
  See commit fab4042fe218e07cf618c9c47c57f81cd596dd80

## 16.2.1
**Debug Deploy and Bug Fixes**
- Added logging and case checks for prod env
  debugging.
- Success on HTTP 302 redirect and failure otherwise.
  Added because PayU sends 200 OK even on failure.

## 16.2.0
**UI Refactor**
- Fixed PayU icon dimensions on payment page.
- Added FontAwesome shield icon for trust logo.

## 16.1.3
**HotFix**
- Removed '.php' trailer from PayU urls.

## 16.1.2
**Hotfix**
- Skincancer value check includes blank and 'Yes/No' values.

## 16.1.1
**Refactor**
- Added reset_session after payment update.
  Allows customer re-sessions.

**HotFixes**
- Fixed age check limits.

## 16.0.0
**Implemented Major enhancements**
- Added parameter checking for payment url
  to handle Typeform after-submit redirects.
- Implemented redirects based on parameters.

## 15.5.1
**Fixed bugs**
- Fixed hrefs for Terms of Use and Privacy Policy pages.
- Fixed prod env asset not found error for above pages.

## 15.5.0
**Refactored Code**
- Shifted Terms of Use and Privacy Policy pages from public
  to controller to allow for better asset handling.

## 15.4.1
**Fixed bugs**
- Fixed rails production environment font and asset not found error.
- Switched css files to scss files to implement above fix.

## 15.4.0
**Implemented enhancements**
- Added hidden fields to typeform iframe src for passing patient details
to typeform.


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
