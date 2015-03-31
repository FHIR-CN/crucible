# Crucible Demo Script
###### _Updated for 03/30/2015_

## Prerequsites
_These need to be updated with production integration of ember-cli frontend._

1. Install [Crucible](https://github.com/fhir-crucible/crucible#getting-started) and [Crucible Frontend](https://github.com/fhir-crucible/crucible-frontend#installation)
2. Start MongoDB service: ```mongod```
3. Start Rails API server
  - Switch to Crucible: ```cd crucible```
  - Reset the database: ```bundle exec rake crucible:db:reset```
  - Launch the Rails server: ```bundle exec rails server```
4. Start the Ember server
  - Switch to Crucible frontend: ```cd crucible-frontend```
  - Launch the Ember server: ```ember serve```

## Script
1. User navigates to the [application homepage](http://crucible-dev.mitre.org) and is presented with the Crucible landing page.
2. User clicks on the "Login" link in the top-right corner of the application and is presented with a login modal dialog.
3. User clicks on the "Register" link in the login modal dialog below the password input field.
4. User is brought to the Crucible registration page, where the user can supply account credentials to create a Crucible account (e.g., ```crucible@example.com``` : ```crucible```).
5. ***User should click on the "Register" button to register an account with the supplied details.***
6. ***User should be brought back to the unauthenticated application homepage and presented with the Crucible landing page.***
7. User clicks on the "Login" link in the top-right corner of the application and is presented with a login modal dialog.
8. User enters in their user credentials in the "Username" and "Password" text fields and clicks on the "Login" button. (e.g., ```crucible@example.com``` : ```crucible```)
9. User is brought to the authenticated application homepage and can see that the navigation bar links have been updated.
10. User clicks into main text field, enters a URL to a FHIR Server under test (e.g., [http://bonfire.mitre.org:8090/fhir-dstu2](http://bonfire.mitre.org:8090/fhir-dstu2)), and clicks the "Begin" button.
11. User is presented with a list of all the tests Crucible can execute against the FHIR server under test.
12. User clicks the pencil-edit icon to supply assign an identifying name to the FHIR server under test: ```bonfire-demo```.
13. User clicks on the "Save" button to persist the new FHIR server under test identifier.
14. User clicks on the "Conformance" tab to view the conformance report of the FHIR server under test and identifies that the **Alert** FHIR resource supports all operations except **Delete** and **Validate**.
15. User can verify that search parameters are available for each FHIR resource by clicking on a row in the Conformance table.
16. User clicks on the "Tests" tab to return to the list of executable tests.
17. User selects the **FormatTest**, **HistoryTest**, **ReadTest**, and **ResourceTestAlert** tests and clicks the "Run" button to begin test execution.
18. User is notified that the test execution is being prepared when the button changes to "Preparing" and is disabled.
19. User is presented with a progress bar that completes as tests are executed and test results are populated on the test results page.
20. User expands the **FormatTest** result and verifies that tests have passed or have been skipped.
21. User expands the **ReadTest** result, selects **R001**, and verifies that the test identified warnings due to the returned HTTP headers.
22. User expands **ResourceTestAlert** result, selects **X030_Alert**, and verifies that the test has failed due to the returned response code (expected 200, received 201).
23. User clicks on the first [Related FHIR Spec Location](http://www.hl7.org/implement/standards/fhir/http.html#update) link and verifies that the server should return 200 if the resource was updated.
24. User views the raw XML response returned from the FHIR server under test in the Data section of the **X030_Alert** test result window.
25. User clicks on the "Conformance" tab to view the conformance report with results highlighting layered over the conformance circles.
26. User hovers over the **Alert** FHIR resource under the **Read** operation column in the conformance results page to see the passed "X000" and "X020" ids in a popover.
27. User hovers over the **Alert** FHIR resource under the **Update** operation column in the conformance results page to see the failed "X030" id in a popover.
28. User clicks on the "Rerun" button to return to the list of executable tests.
29. User clicks on the "Dashboard" link in the top-right corner to navigate to the User Dashboard.
30. User is presented with a "Please wait..." loading dialog as the application retrieves all the associated user information from the application server.
31. User is presented with a list of color-coded servers that they have previously tested, and an empty graphic for their aggregate tests summary.
32. User selects the "bonfire-demo" server and can see1) histogram visualization updating with test runs available for that server and 2) test run summaries populating below the visualization.
33. User can optionally select any additional servers they have previously tested to see more comprehensive summary information.
34. User clicks on the total number of tests link ("38 tests") on the right-hand side of a Test Runs summary row to navigate to the particular test run.
35. User clicks on the "Logout" link in the top-right corner of the application and is returned to the unauthenticated application homepage.
