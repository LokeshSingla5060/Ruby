require 'selenium-webdriver'
require 'yaml'
#This class contains method to perform search for freelancers with provided keywords and verify the keyword in results of freelancer list.
class NavBar

    def initialize(driver)
        @driver=driver
        @locators= YAML.load_file('../objectRepository/HomePagelocators.yml')

    end

    def searchKeyword(testData,log)
        begin
            log.info '####### Search FreeLancer for '+testData.freelancer_keyword+' #######'
            log.info 'Click on Search Freelancer textfield'
            @driver.find_element(:xpath, @locators['searchTextField']).click
            log.info 'Type '+testData.freelancer_keyword+' in Search textfield'
            @driver.find_element(:xpath, @locators['searchTextField']).send_keys testData.freelancer_keyword
            log.info 'Click on Search Icon'
            @driver.find_element(:xpath, @locators['searchIcon']).click
            log.info 'Wait for results'
        end
        rescue StandardError => e  
            puts e.message
            log.error "searchKeyword method throwing "+e.message
        end
end
