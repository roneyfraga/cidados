
# máximo de páginas 2000 com 50 elementos na página

# query 
# TOPIC: ("biofuel*"  or "bioenergy"  or "biomethan*"  or "bioethanol*"  or "biodiesel*"  or "biogas*"  or "biooil*"  or "biorefin*"  or "synfuel*"  or "syngas*"  or "synoil*"  or "biohydrogen*"  or "biopropanol*"  or "biobutanol*"  or "biochar*")
# Refined by: DOCUMENT TYPES: ( ARTICLE OR REVIEW )
# Timespan: All years. Indexes: SCI-EXPANDED, SSCI, A&HCI, CPCI-S, CPCI-SSH, ESCI.

#___________________________________ 

from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
import time
import os
import datetime

driver = webdriver.Firefox() 
driver.get('https://www.periodicos.capes.gov.br')

# após abrir, logar no WoS e refinar a query
# artigos
# ordenados dos mais velhos para os mais novos
# 2023:2017 excluindo
driver.get('https://www-webofscience.ez52.periodicos.capes.gov.br/wos/woscc/summary/4a8f92c9-d986-4ec6-ab50-a7d8f9d12ae0-4725d22e/date-ascending/1383') 

# MUDAR NO NAGEGADOR download_folder
# download_folder = '/mnt/ssd1tb/Pessoal/Documents/Rworkspace/2022-bioenergy/bibs'
download_folder = '/mnt/raid0/Pessoal/Documents/Rworkspace/2022-bioenergy/bibs'

# ---
#  log file header
total_paginas = driver.find_element("xpath", "/html/body/app-wos/div/div/main/div/div/div[2]/app-input-route/app-base-summary-component/div/div[2]/app-page-controls[1]/div/form/div/span").text

with open('log.txt', 'a') as a_writer:
    a_writer.write( 
            '# date: ' +
            datetime.datetime.now().strftime("%Y-%m-%d_%X") +
            '\n' + 
            '# url: ' +
            driver.current_url + 
            '\n' + 
            '# query:  ' +
            driver.title + 
            '\n' + 
            '# total documents: ' +
            driver.find_element('xpath', '/html/body/app-wos/div/div/main/div/div/div[2]/app-input-route/app-base-summary-component/app-search-friendly-display/div[1]/app-general-search-friendly-display/h1/span').text +
            '\n' +
            '# total pages: ' + 
            total_paginas +
            '\n' + 
            '# ' +
            '\n')
# ---

# quantidade de páginas para navegar
# PAREI NA 531
paginas = range(1383, 1399, 1)


for pagina in paginas:

    # download folder - mudar no nagegador
    baixados = len(os.listdir(download_folder)) 
    
    try:
        # export
        export = WebDriverWait(driver, 10).until(
            EC.presence_of_element_located((By.XPATH, "/html/body/app-wos/div/div/main/div/div/div[2]/app-input-route/app-base-summary-component/div/div[2]/app-page-controls[1]/div/app-export-option/div/app-export-menu/div/button/span[1]"))
        )
        export.click()
        # bibtex
        bibtex = WebDriverWait(driver, 10).until(
            EC.presence_of_element_located((By.XPATH, '//*[@id="exportToBibtexButton"]'))
        )
        bibtex.click()
        # record content
        recordcontent = WebDriverWait(driver, 10).until(
            EC.presence_of_element_located((By.XPATH, '/html/body/app-wos/div/div/main/div/div/div[2]/app-input-route[1]/app-export-overlay/div/div[3]/div[2]/app-export-out-details/div/div[2]/form/div/div[1]/wos-select/button/span[1]'))
        )
        recordcontent.click()
        # custom selecton
        customselection = WebDriverWait(driver, 10).until(
            EC.presence_of_element_located((By.XPATH, '/html/body/app-wos/div/div/main/div/div/div[2]/app-input-route[1]/app-export-overlay/div/div[3]/div[2]/app-export-out-details/div/div[2]/form/div/div[1]/wos-select/div/div/div[2]/div[5]/span'))
            )
        customselection.click()
        # download
        download = WebDriverWait(driver, 10).until(
            EC.presence_of_element_located((By.XPATH, '/html/body/app-wos/div/div/main/div/div/div[2]/app-input-route[1]/app-export-overlay/div/div[3]/div[2]/app-export-out-details/div/div[2]/form/div/div[2]/button[1]/span[1]/span'))
        )
        download.click()

        # já baixou?
        baixando = len(os.listdir(download_folder))

        # mudar de pagina depois de baixado 
        while baixados == baixando:
            time.sleep(5)
            baixando = len(os.listdir(download_folder))
            if baixados != baixando:
                # next page
                driver.find_element('xpath', '/html/body/app-wos/div/div/main/div/div/div[2]/app-input-route/app-base-summary-component/div/div[2]/app-page-controls[1]/div/form/div/button[2]').click()

    finally:
        print(pagina)
        with open('log.txt', 'a') as a_writer:
            a_writer.write( 
                    str(pagina) +
                    ' of ' +
                    str(total_paginas) + 
                    ' at ' + 
                    datetime.datetime.now().strftime("%Y-%m-%d_%X") + 
                    '\n' )
        

#___________________________________ 

