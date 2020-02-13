require 'selenium-webDriver'
#Create WebDriver Instance
module DriverManager
    class UIDriver
        #Initiate WebDriver instance
        def initiateDriver(testData,log)
            begin
                @profile = Selenium::WebDriver::Firefox::Profile.new
                @profile['browser.cache.disk.enable'] = false
                @profile['browser.cache.memory.enable'] = false
                @profile['browser.cache.offline.enable'] = false
                @profile['network.http.use-cache'] = false
                @options = Selenium::WebDriver::Firefox::Options.new(profile: @profile)
                driver = Selenium::WebDriver.for :"#{testData.browser_name}", options: @options

                log.info 'Initiate '+testData.browser_name+' browser'
                driver.manage.window.maximize
                driver.navigate.to "#{testData.app_url}"
                log.info 'Navigate to '+testData.app_url
                return driver
            rescue StandardError => e  
                puts e.message  
                log.info 'Unable to open browser'
                log.error e.message
            end
        end
    end
end
