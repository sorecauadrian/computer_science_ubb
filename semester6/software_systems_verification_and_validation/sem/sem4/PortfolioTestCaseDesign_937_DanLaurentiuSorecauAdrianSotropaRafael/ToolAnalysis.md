# Tool Analysis

> **Title**: *Pynguin: Automated Unit Test Generation for Python*
> 
> **DOI**: [[2202.05218] Pynguin: Automated Unit Test Generation for Python](https://doi.org/10.48550/arXiv.2202.05218)
> 
> **Team members**: Dan Laurențiu, Șorecău Adrian-Vasile, Șotropa Konstantinos-Rafael

#### Installing the tool

The Pynguin team provides a [Github Repository](https://github.com/se2p/pynguin/tree/main) containing some example files to generate tests from alongside a README file on how to put the tool on those files.

After running the script, a .py file was generated containing unit tests.

![script.png](\\wsl.localhost\Ubuntu\home\sorecauadrian\computer_science_ubb\semester6\software_systems_verification_and_validation\sem\sem4\PortfolioTestCaseDesign_937_DanLaurentiuSorecauAdrianSotropaRafael\screenshots\script.png)

![test.png](\\wsl.localhost\Ubuntu\home\sorecauadrian\computer_science_ubb\semester6\software_systems_verification_and_validation\sem\sem4\PortfolioTestCaseDesign_937_DanLaurentiuSorecauAdrianSotropaRafael\screenshots\test.png)

#### Using the tool

For the examples provided by them, 

![example.png](\\wsl.localhost\Ubuntu\home\sorecauadrian\computer_science_ubb\semester6\software_systems_verification_and_validation\sem\sem4\PortfolioTestCaseDesign_937_DanLaurentiuSorecauAdrianSotropaRafael\screenshots\example.png)

the coverage was 100%. 

Using it was straight-forward, i just had to run the tests to see if they work or not. In the command line I could see the progress of the test-generation scripts and the phases Pynguin went through until it decided to stop.

![phase1.png](\\wsl.localhost\Ubuntu\home\sorecauadrian\computer_science_ubb\semester6\software_systems_verification_and_validation\sem\sem4\PortfolioTestCaseDesign_937_DanLaurentiuSorecauAdrianSotropaRafael\screenshots\phase1.png)

Mutations were one important phase of test-generation as it removed useless lines from the tests so they are optimised.

![phase2.png](\\wsl.localhost\Ubuntu\home\sorecauadrian\computer_science_ubb\semester6\software_systems_verification_and_validation\sem\sem4\PortfolioTestCaseDesign_937_DanLaurentiuSorecauAdrianSotropaRafael\screenshots\phase2.png)

#### Findings and benefits

Pynguin significantly reduces the manual effort required to write unit tests by automatically generating them based on the existing codebase.

Integrating Pynguin into the development workflow offers a practical solution for automating unit test creation in Python projects. Its ease of installation and use, combined with the ability to produce high-coverage test suites, makes it a valuable tool for developers aiming to enhance code reliability and maintainability.
