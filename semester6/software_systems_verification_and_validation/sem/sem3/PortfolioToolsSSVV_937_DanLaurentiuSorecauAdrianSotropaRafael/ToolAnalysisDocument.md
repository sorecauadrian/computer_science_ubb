# Tool Analysis Document

> **Title**: *PseudoSweep: A Pseudo-Tested Code Identifier*
> 
> **DOI**: [10.1109/ICSME58944.2024.00094](https://doi.org/10.1109/ICSME58944.2024.00094)
> 
> **Team members**: Dan Laurențiu, Șorecău Adrian-Vasile, Șotropa Konstantinos-Rafael

#### Installing the tool

The PseudoSweep team provides a [Github Repository](https://github.com/PseudoTested/pseudosweep-demo/tree/main) containing the PseudoSweep jar file alongside a shell script for running PseudoSweep on a specific file.

From there, I had to clone a repository that has a Java class and some tests for it. I chose apache's [commons-codec](https://github.com/apache/commons-codec/tree/master) repository containing the [Caverphone](https://en.wikipedia.org/wiki/Caverphone)'s class because that's one of the repositories the PseudoSweep team tested on. 

I had to add the PseudoSweep dependencies on the pom.xml file of the repository, to add the specific file path to the file containing the tested class on the shell file and to rename all "ps-data" occurances to "PS-data" because of some compatibility issues with my WSL machine.

After running the script, a zip file is generated containing PseudoSweep's report.

#### Using the tool

The generated zip file can help you identify which lines from the provided Java file are pseudo-tested. For the example, as the file i provided has a lot of expressions, i found that there are 23 coverage gaps for the expressions

![expressions.png](https://github.com/sorecauadrian/computer_science_ubb/blob/master/semester6/software_systems_verification_and_validation/sem/sem3/PortfolioToolsSSVV_937_DanLaurentiuSorecauAdrianSotropaRafael/screenshots/expressions.png)

Following the coverageGap array, we will search for the statement with the id 6

![statement.png](https://github.com/sorecauadrian/computer_science_ubb/blob/master/semester6/software_systems_verification_and_validation/sem/sem3/PortfolioToolsSSVV_937_DanLaurentiuSorecauAdrianSotropaRafael/screenshots/statement.png)

As we can see, the pseudo-tested statement starts at line 68 and ends on the same line

![68.png](https://github.com/sorecauadrian/computer_science_ubb/blob/master/semester6/software_systems_verification_and_validation/sem/sem3/PortfolioToolsSSVV_937_DanLaurentiuSorecauAdrianSotropaRafael/screenshots/68.png)

So this means that if we were to remove this line, all the tests would have the same output, thus, even if the tests go throught this line, it is not tested.

![test.png](https://github.com/sorecauadrian/computer_science_ubb/blob/master/semester6/software_systems_verification_and_validation/sem/sem3/PortfolioToolsSSVV_937_DanLaurentiuSorecauAdrianSotropaRafael/screenshots/test.png)

And as we can see, there is not a single string in the test code that contains the "rough", thus confirming that line 68 is not tested properly.

#### Findings and benefits

Another example, and easier to understand, is the example displayed in the paper.

![example.png](https://github.com/sorecauadrian/computer_science_ubb/blob/master/semester6/software_systems_verification_and_validation/sem/sem3/PortfolioToolsSSVV_937_DanLaurentiuSorecauAdrianSotropaRafael/screenshots/example.png)

As observed, the third line is pseudo-tested as the test only checks for the the strings added in the second and forth line.

PseudSweep reveals false confidence - code looks tested, but isn't. It shows parts of your code that are covered by tests (executed), but are not actually validated.

It's useful for identifying dead branches, untested edge cases and forgotten utility methods. Also, some numbers can reveal if a functionality is too thoroughly tested (lots of tests, few real differences), or if it superficially tested.
