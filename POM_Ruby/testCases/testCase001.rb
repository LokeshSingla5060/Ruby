require 'selenium-webdriver'
require '../libraryUtils/DriverManager'
require '../libraryUtils/FileManager'
require '../entities/TestData'
require '../pageObjects/HomePage'
require '../pageObjects/FreelancerProfilePage'
require '../pageObjects/NavBar'
require 'yaml'
require 'logger'
require 'date'


#define objects
    @config = YAML.load_file('../config/environmentConfig.yml')
    @test_Data= YAML.load_file('../config/testData.yml')
    driverManager =DriverManager::UIDriver.new
    @demo_data = TestData.new

#define log object
    log = Logger.new(FileManager.new.createFile('../logs')+'/'+'log.txt')
    log.info "############ Test Case testCase001 Execution started ############"

#set the test Data
    @demo_data.browser_name=@config['browser_name']
    log.info "Test Data is set for browser name : "+@demo_data.browser_name
    @demo_data.app_url=@config['app_url']
    log.info "Test Data is set for application url : "+@demo_data.app_url
    @demo_data.freelancer_keyword=@test_Data['keyword']
    log.info "Test Data is set for keyword : "+@demo_data.freelancer_keyword

#define webdriver instance
    log.info "Initializing WebDriver instance"
    driver =driverManager.initiateDriver(@demo_data,log)
    log.info "WebDriver instance is initialized"

#Intiate class objects
    navBar=NavBar.new(driver)
    homePage = HomePage.new(driver)
    freeLancerProfilePage=FreelancerProfilePage.new(driver)

#perform search freelancer steps
    navBar.searchKeyword(@demo_data,log)

#store freelancer data in list
    freeLancersData=homePage.storeFreeLancersList(@demo_data,log)

#verify searched keyword in freelancers list
    homePage.verifyKeywordInSearchedFreelancersList(@demo_data,log,freeLancersData)

#click on a random profile
    profileName=freeLancerProfilePage.selectRandomProfile(log,freeLancersData)

#Call verify Atrribute In profiles 
    freeLancerProfilePage.verifyAttributeInProfiles(log,freeLancersData,profileName)

log.info "############ Test Case testCase001 Execution completed ############"