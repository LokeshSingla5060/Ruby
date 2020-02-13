require 'selenium-webdriver'
require 'yaml'
#This class contains method to perform search for freelancers with provided keywords and verify the keyword in results of freelancer list.
class HomePage

    def initialize(driver)
        @driver=driver
        @locators= YAML.load_file('../objectRepository/HomePagelocators.yml')

    end
    #Search for freelancer and store the data
    def storeFreeLancersList(testData,log)
        begin
            log.info '####### Store freelancers record in a map #######'
       
            @data={}
            @driver.find_elements(css: @locators['search_results']).each.with_index do |cell, i|
            k =i+1
            # fetch freelancer name present on screen
            freeLancerName=@driver.find_element(:xpath, "(//a[@class='freelancer-tile-name']/span)["+k.to_s+"]").text
            @data[freeLancerName] = cell.text
            log.info "Freelancer Name : "+freeLancerName            
        end
        rescue StandardError => e  
            puts e.message  
            log.error "storeFreeLancersList method throwing "+e.message
        end
            return @data
    end

    #verify Keyword in the freelancers list
    def verifyKeywordInSearchedFreelancersList(testData,log,freeLancersData)
        begin
            log.info '####### Verify ' +testData.freelancer_keyword+' Keyword in the present freelancer List #######'

            #store keys to iterate map
            keys = freeLancersData.keys
            #for loop to iterate map
            for n in 0..keys.length-1 do            
                if(@data.fetch(keys[n]).downcase[testData.freelancer_keyword])
                    log.info "**** Freelancer "+keys[n]+" is present with keyword ****"
                else
                    log.info "**** Freelancer "+keys[n]+" is not present with keyword ****"
                end
            end
        rescue StandardError => e  
            puts e.message  
            log.error "verifyKeywordInSearchedFreelancersList method throwing "+ e.message
        end

    end
end
