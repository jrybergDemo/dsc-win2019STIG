Configuration win2019STIG
{
    Import-DscResource -ModuleName 'PowerSTIG' -ModuleVersion 4.11.0
    Import-DscResource -ModuleName 'PSDscResources' -ModuleVersion 2.12.0.0

    Node localhost
    {
        WindowsServer STIGs
        {
            OsVersion    = '2019'
            OSRole       = 'MS'
            Exception    = @{
                'V-205629' = '0' #BAD LOGON ATTEMPTS CONFIGURED TO THREE OR LESS.
                'V-205672' = '0' #DENY ACCESS FROM THE NET ON DC MEMBER SERVERS.
                'V-205659' = '0' #MAXIMUM PASSWORD AGE MUST BE CONFIGURED TO 60 DAYS OR LESS.
                'V-205811' = '0' #USER ACCOUNT CONTROL APPROVAL MODE FOR THE BUILT-IN ADMINISTRATOR MUST BE ENABLED.
                'V-205715' = '0' #PREVENT ELEVATED PRIVILEGES FROM BEING USED OVER THE NETWORK ON DOMAIN-JOINED MEMBER SERVERS.
            }
            SkipRule     = @(
                'V-205630' #Lockout timer
                'V-205795' #Lockout timer
                'V-205675' #DENY LOG ON LOCALLY USER RIGHT ON DOMAIN-JOINED MEMBER SERVERS MUST BE CONFIGURED TO PREVENT ACCESS.
                'V-205667' #DENY ACCESS TO THIS COMPUTER FROM THE NETWORK USER RIGHT ON DOMAIN CONTROLLERS MUST BE CONFIGURED TO PREVENT UNAUTHENTICATED ACCESS
                'V-205675' #DENY LOG ON LOCALLY USER RIGHT ON DOMAIN-JOINED MEMBER SERVERS MUST BE CONFIGURED TO PREVENT ACCESS FROM HIGHLY PRIVILEGED DOMAIN ACCOUNTS AND FROM UNAUTHENTICATED ACCESS ON ALL SYSTEMS
                'V-205733' #DENY LOG ON THROUGH REMOTE DESKTOP SERVICES USER RIGHT ON DOMAIN-JOINED MEMBER SERVERS MUST BE CONFIGURED TO PREVENT ACCESS FROM HIGHLY PRIVILEGED DOMAIN ACCOUNTS
                'V-205711' #(WINRM) CLIENT MUST NOT USE BASIC AUTHENTICATION.
                'V-205816' #(WINRM) CLIENT MUST NOT ALLOW UNENCRYPTED TRAFFIC.
                'V-205713' #(WINRM) SERVICE MUST NOT USE BASIC AUTHENTICATION.
                'V-205816' #(WINRM) CLIENT MUST NOT ALLOW UNENCRYPTED TRAFFIC.
            )
        }

        WindowsDefender Schedule
        {
            StigVersion = '2.1'
        }

        Registry EnableCertPaddingCheck
        {
            Ensure      = 'Present'
            Key         = 'HKEY_LOCAL_MACHINE\Software\Microsoft\Cryptography\Wintrust\Config'
            ValueName   = 'EnableCertPaddingCheck'
            ValueData   = '1'
        }

        Registry EnableCertPaddingCheck64
        {
            Ensure      = 'Present'
            Key         = 'HKEY_LOCAL_MACHINE\Software\Wow6432Node\Microsoft\Cryptography\Wintrust\Config'
            ValueName   = 'EnableCertPaddingCheck'
            ValueData   = '1'
        }

        Registry SpecExMask
        {
            Ensure      = 'Present'
            Key         = 'HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management'
            ValueName   = 'FeatureSettingsOverrideMask'
            ValueData   = '3'
        }

        Registry SpecExOverride
        {
            Ensure      = 'Present'
            Key         = 'HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management'
            ValueName   = 'FeatureSettingsOverride'
            ValueData   = '72'
        }
    }
}
