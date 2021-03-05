# Shock Experiment

This Xcode workspace demonstrates how to use JustEat's [Shock](https://github.com/justeat/Shock) library in order to mock the server for faster, more reliable UI tests.

The workspace contains an application target ([ShockExperiment](ShockExperiment)) and a UI testing target ([ShockExperimentUITests](ShockExperimentUITests)). The application is super simple such that all it does it fire a network request on load to GET a list of Star Wars characters and then updates a label to say how many characters were fetched (if successful) or that something went wrong (if unsuccessful). The UI testing target contains a number of tests which each mock the server to return a particular response, launch the application and then assert that the application displays the expected text.

