# Crucible Demo Script
###### _Updated for 04/15/2015_

## Prerequsites
_These need to be updated with production integration of ember-cli frontend._
1. Start MongoDB service: ```mongod```
2. Start Rails API server
  - Switch to Crucible: ```cd crucible```
  - Reset the database: ```bundle exec rake crucible:db:reset```
  - Launch the Rails server: ```bundle exec rails server```
3. Start the Ember server
  - Switch to Crucible frontend: ```cd crucible-frontend```
  - Launch the Ember server: ```ember serve```

## Script
1. User navigates to the [application homepage](http://crucible-dev.mitre.org) and is presented with the Crucible landing page.
2. User clicks on the "Login" link in the top-right corner of the application and is presented with a login modal dialog.
3. User enters in their user credentials in the "Username" and "Password" text fields and clicks on the "Login" button. (e.g., ```crucible@example.com``` : ```crucible```)
4. User is brought to the authenticated application homepage and can see that the navigation bar links have been updated.
5. User clicks into main text field, enters a URL to a FHIR Server under test (e.g., [http://bonfire.mitre.org:8090/fhir-dstu2](http://bonfire.mitre.org:8090/fhir-dstu2)), and clicks the "Begin" button.
6. ***User should be presented with a "Please Wait..." modal dialog while Crucible fetches the server's conformance.***
7. User is presented with a list of all the tests Crucible can execute against the FHIR server under test.
8. User clicks on the "Conformance" tab to view the conformance report of the FHIR server under test and identifies that the **Alert** FHIR resource supports all operations except **Delete** and **Validate**.
9. User clicks on the "Tests" tab to return to the list of executable tests.
10. User selects the **FormatTest**, **HistoryTest**, **ReadTest**, and **ResourceTestAlert** tests and clicks the "Run" button to begin test execution.
11. ***User should be presented with a progress bar that completes as tests are executed and test results are populated on the test results page.***
12. User expands the **FormatTest** result and verifies that tests have passed or have been skipped.
13. User expands **ResourceTestAlert** result, selects **X030_Alert**, and verifies that the test has failed due to the returned response code (expected 200, received 201).
14. User clicks on the first [Related FHIR Spec Location](http://www.hl7.org/implement/standards/fhir/http.html#update) and verifies that the server should return 200 if the resource was updated.
15. User clicks on the "Conformance" tab to view the conformance report with results highlighting layered over the conformance circles.
16. ***User should be able to hover over the Alert resource under the Update operation column in the conformance results page to see the failed "X030" id in a popover.***
17. User clicks on "Logout" link in the top-right corner of the application and is returned to the unauthenticated application homepage.
