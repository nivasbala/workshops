# Tomcat

## Tomcat Project Done by Srini Bala

### Cookbook 
  This cookbook contains the Installation of **Tomcat** on **centOs**

### Template
  - The Template for tomcat.service file created
  - Created using chef generate template

### Receipe
  - Recipe update to include instructions from **INSTRUCTION.md**

### kitchen.yml
  - Kitchen.yml was change to include a local interface so webpage can be accessed from the host

### Testing Done
  - Ran kitchen create and kitchen converge
  - Ran kitchen login to verify the services were started 
  - Ran cookstyle - Corrected all errors
  - Ran foodcritic - Corrected errors
  - Ran InSpec Test cases

#### Inspec Test Cases
  - Test to check if Java Package installed
  - Test to check Group and User tomcat created
  - Test to check if /opt/tomcat was created and permissions and group set
  - Test to check if tomcat.service file was created
  - Test to check if tomcat service is running
  - Test to check output of curl on localhost:8080
  - Ran **kitchen test** sucessfully
