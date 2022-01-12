# About

This Xcode workspace demonstrates how to use JustEat's [Shock](https://github.com/justeat/Shock) library to mock out the server for faster, more reliable UI tests.

The workspace contains an application target ([ShockExperiment](ShockExperiment)) and a UI testing target ([ShockExperimentUITests](ShockExperimentUITests)). The application is super simple such that all it does it fire a network request on load to fetch a list of Star Wars characters and then updates a label to say how many characters were fetched (if successful) or that something went wrong (if unsuccessful). The UI testing target contains a number of tests which each (1) mock the server to return a particular response, (2) launch the application and then (3) assert that the application displays the expected text based on the server response.

# Setup

Clone this repository, open the [ShockExperiment.xcworkspace](ShockExperiment.xcworkspace) file in Xcode, build the project and run the tests.

This workspace assumes you have a GitHub source control account added to your Xcode preferences. Xcode uses your GitHub account to fetch this workspace's Swift package dependencies.
