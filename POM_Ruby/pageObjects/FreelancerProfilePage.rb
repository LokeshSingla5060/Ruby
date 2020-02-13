require 'selenium-webdriver'
require 'yaml'
#This class contains method to perform click on freelancer profile and verify the attribute presence on the page.
class FreelancerProfilePage

    def initialize(driver)
        @driver=driver
        @locators= YAML.load_file('../objectRepository/FreelancerProfileLocators.yml')

    end

    #To fetch a random number and click on that profile
    def selectRandomProfile(log,freeLancersData)
        begin
            log.info '####### Search a random profile #######'

            keys = freeLancersData.keys
            #click on user profile
            randomNumber=rand(1..keys.length-1)
            log.info "Profile number is selected "+ (randomNumber+1).to_s
            freelancerName=@driver.find_element(:xpath, "(//a[@class='freelancer-tile-name']/span)["+randomNumber.to_s+"]").text
            log.info "Click on "+ freelancerName+ " profile"

            @driver.find_element(:xpath, "(//a[@class='freelancer-tile-name']/span)["+randomNumber.to_s+"]").click
            log. info freelancerName+" is selected"
        rescue StandardError => e  
                puts e.message  
                log.error "selectRandomProfile method throwing "+e.message
        end
        return freelancerName
    end


    def verifyAttributeInProfiles(log,freeLancersData,profileName)
        begin
            log.info '####### Verify Title attribute in selected freelancer profile #######'
                
            title=@driver.find_element(:xpath,@locators['title']).text
            log.info "Title : "+title

            if freeLancersData.fetch(profileName)[title]
            log.info "**** Title attribute is verified successfully ****"
            else
            log.info "**** Title attribute is not verified successfully ****"
            end
        rescue StandardError => e  
            puts e.message  
            log.error "verifyAttributeInProfiles method throwing "+e.message    
        end
    end 



end