# Azure User Certificate Creator

This script will use an existing openSSL certificate authourity to issue certificates for users to use when authenticating against Azure Active Directory with Certificate Authentication Enabled.

# Warning
This is a proof-of-concept and employs some poor security practice, please be careful when storing static passwords and/or bash history.

For more info on Azure Cert Authentication, please see https://learn.microsoft.com/en-us/azure/active-directory/authentication/concept-certificate-based-authentication
