# About

This Xcode workspace demonstrates how to use JustEat's [Shock](https://github.com/justeat/Shock) library to mock out the server for faster, more reliable UI tests.

The workspace contains an application target ([ShockExperiment](ShockExperiment)) and a UI testing target ([ShockExperimentUITests](ShockExperimentUITests)). The application is super simple such that all it does it fire a network request on load to fetch a list of Star Wars characters and then updates a label to say how many characters were fetched (if successful) or that something went wrong (if unsuccessful). The UI testing target contains a number of tests which each:

1. Mock the server to return a particular response;
1. Launch the application; and then
1. Assert that the application displays the expected text based on the server response.

# Setup

1. Clone this repository;
1. Open the [ShockExperiment.xcworkspace](ShockExperiment.xcworkspace) file in Xcode;
1. Build the project;
1. Run the tests.

This workspace assumes you have a GitHub source control account added to your Xcode preferences. Xcode uses your GitHub account to fetch this workspace's Swift package dependencies.
