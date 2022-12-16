# This can be used to enforce default apps within an AD GPO.
----------
# Setup a machine with the desired configuration of choice, then use script below to export.
# Clean up .xml file via Excel.
# Point GPO to exported file in shared location.
----------
# Group Policy Editor
# Administrative Templates\Windows Components\File Explorer\Set a default associations configuration file.
# Click Enabled
# Options Area = 'defaultassociations.xml' (attached file...)
----------
Dism /Online /Export-DefaultAppAssociations:c:\defaultassociations.xml
