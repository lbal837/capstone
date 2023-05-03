# Purpose

Essentially any lambda functions that exceed a storage limit of 10MB can't be edited through the built-in editor. Hence,
for documentation and accessibility we've stored all the lambda functions which are above 10MB in our local repository.

## Modifying and using

To modify and use the lambda functions, edit them in their respective folder, then create a zip file, for
example `AddCaregiverToRDS.zip`, which will hold all the folders and files in the `AddCareGiverToRDS` folder.

Ensure you run `npm i` in the corresponding directory too.

The upload the zip file into the respective lambda function.
