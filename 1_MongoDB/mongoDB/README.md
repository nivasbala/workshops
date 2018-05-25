# mongoDB

## 1_MongoDB Project done by Srini Bala

### Cookbook
  This cookbook contains the Installation of **MongoDB** on **centOS**

### Template
  - Template for mongo.repo files (for 32 and 64 bit os) 
  - Created using chef generate template

### Receipe
  - Recipe to include instructions on **install.rb**
  
### Testing Done
  - Ran kitchen create and kitchen converge
  - Ran kitchen login to verify the services were started 
  - Ran cookstyle - Corrected all errors
  - Ran foodcritic - Corrected errors
  - Ran InSpec Test cases

#### Inspec Test Cases
  - Test to check if mongodb-org was installed
  - Test to check if the service was enabled and running
  - Test to check if port 27017 is listening
  - Test to check if restart of mongodb after reboot is enabled (chkconfig)
  - Ran **kitchen test** sucessfully
