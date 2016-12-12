"  __      __.___.____    .____    .___   _____      _____       _____  _________     _____ ________________________ ___  ____ _____________ "
" /  \    /  \   |    |   |    |   |   | /  _  \    /     \     /     \ \_   ___ \   /  _  \\______   \__    ___/   |   \|    |   \______   \"
" \   \/\/   /   |    |   |    |   |   |/  /_\  \  /  \ /  \   /  \ /  \/    \  \/  /  /_\  \|       _/ |    | /    ~    \    |   /|       _/"
"  \        /|   |    |___|    |___|   /    |    \/    Y    \ /    Y    \     \____/    |    \    |   \ |    | \    Y    /    |  / |    |   \"
"   \__/\  / |___|_______ \_______ \___\____|__  /\____|__  / \____|__  /\______  /\____|__  /____|_  / |____|  \___|_  /|______/  |____|_  /"
"        \/              \/       \/           \/         \/          \/        \/         \/       \/                \/                  \/ "
"   _________ __            .___             __     _  _  _______________  _______  ________  ________    _____  _______  _______  ____      "
"  /   _____//  |_ __ __  __| _/____   _____/  |___| || |_\_____  \   _  \ \   _  \ \_____  \ \_____  \  /  |  | \   _  \ \   _  \/_   |     "
"  \_____  \\   __\  |  \/ __ |/ __ \ /    \   __\   __   //  ____/  /_\  \/  /_\  \  _(__  <  /  ____/ /   |  |_/  /_\  \/  /_\  \|   |     "
"  /        \|  | |  |  / /_/ \  ___/|   |  \  |  |  ||  |/       \  \_/   \  \_/   \/       \/       \/    ^   /\  \_/   \  \_/   \   |     "
" /_______  /|__| |____/\____ |\___  >___|  /__| /_  ~~  _\_______ \_____  /\_____  /______  /\_______ \____   |  \_____  /\_____  /___|     "
"         \/                 \/    \/     \/       |_||_|         \/     \/       \/       \/         \/    |__|        \/       \/          "
" ________                             ___.                   _______________  ____  ________                                                "
" \______ \   ____   ____  ____   _____\_ |__   ___________   \_____  \   _  \/_   |/  _____/                                                "
"  |    |  \_/ __ \_/ ___\/ __ \ /     \| __ \_/ __ \_  __ \   /  ____/  /_\  \|   /   __  \                                                 "
"  |    `   \  ___/\  \__\  ___/|  Y Y  \ \_\ \  ___/|  | \/  /       \  \_/   \   \  |__\  \                                                "
" /_______  /\___  >\___  >___  >__|_|  /___  /\___  >__| /\  \_______ \_____  /___|\_____  /                                                "
"         \/     \/     \/    \/      \/    \/     \/     )/          \/     \/           \/                                                 "
" ___________            ________                       .__           _________.__                                                           "
" \_   _____/__________  \______ \   ____   ____   ____ |__| ______  /   _____/|__| _____ ______  __________   ____                          "
"  |    __)/  _ \_  __ \  |    |  \_/ __ \ /    \ /    \|  |/  ___/  \_____  \ |  |/     \\____ \/  ___/  _ \ /    \                         "
"  |     \(  <_> )  | \/  |    `   \  ___/|   |  \   |  \  |\___ \   /        \|  |  Y Y  \  |_> >___ (  <_> )   |  \                        "
"  \___  / \____/|__|    /_______  /\___  >___|  /___|  /__/____  > /_______  /|__|__|_|  /   __/____  >____/|___|  /                        "
"      \/                        \/     \/     \/     \/        \/          \/          \/|__|       \/           \/                         "
#################################################################################################################################
#create a string object, let the shell display it
"+-----------------------+"
"| Operating System Info |"
"+-----------------------+"
#1. Display the OS manufacturer, name, version, OS architecture, registered user, and serial number.

#retrieving data using WMI, create an object
#win32_operating system represents a Windows-based operating system installed on a computer
Get-WmiObject -class win32_operatingsystem |
foreach {
            New-Object -TypeName psobject -Property @{
                # $_ is the current object in a pipeline
                Manufacturer=$_.manufacturer
                Caption=$_.caption
                #retrieve the "version" inherited property from win32_operatingsystem class
                Version=$_.version
                OSArchitecture=$_.osarchitecture
                RegisteredUser=$_.registereduser
                SerialNumber=$_.serialnumber
        }
}|
#Format output as list, assign order of properties
Format-List Manufacturer, Caption, Version, OSArchitecture, RegisteredUser, SerialNumber 
#################################################################################################################################
"+---------+"
"| PC Info |"
"+---------+"
#2. Display information about the system including computer manufacturer, 
#   model, windows name, windows domain name, primary owner name, system type.

#represents a computer system running Windows
Get-WmiObject -class win32_computersystem |
#foreach - execute object once for each object
foreach {
            New-Object -TypeName psobject -Property @{
                Manufacturer=$_.manufacturer
                Model=$_.model
                Caption=$_.caption
                Domain=$_.domain
                PrimaryOwnerName=$_.primaryownername
                SystemType=$_.systemtype
        }
}| 
Format-List Manufacturer, Model, Caption, Domain, PrimaryOwnerName, SystemType 
#################################################################################################################################
"+-----------+"
"| BIOS Info |"
"+-----------+"
#3. Display the BIOS manufacturer, name, version, and serial number.

#represents the basic input/output services installed on a computer
Get-WmiObject -class win32_bios |
foreach {
            New-Object -TypeName psobject -Property @{
                Manufacturer=$_.manufacturer
                Description=$_.description
                Version=$_.version
                SMBIOSBIOSVersion=$_.smbiosbiosversion
                #Note: Serial returns as "default string" and I don't know why
                SerialNumber=$_.serialnumber
        }
}|
Format-List Manufacturer, Description, Version, SMBIOSBIOSVersion, SerialNumber 
#################################################################################################################################
"+----------------+"
"| Processor Info |"
"+----------------+"
#4. Display the CPU manufacturer, model description, number of cores, maximum clock speed, and cache size(s).

#represents the processor installed on a system
Get-WmiObject -class win32_processor |
foreach {
            New-Object -TypeName psobject -Property @{
                Manufacturer=$_.manufacturer
                Name=$_.name
                Caption=$_.caption
                NumberofCores=$_.numberofcores
                MaxClockSpeed=$_.maxclockspeed
                L2CacheSize=$_.l2cachesize
                L3CacheSize=$_.l3cachesize
        }
}|
Format-List Manufacturer, Name, Caption, NumberofCores, MaxClockSpeed, L2CacheSize, L3CacheSize 
#################################################################################################################################
"+-------------+"
"| Memory Info |"
"+-------------+"
#5.	Display the RAM manufacturer, capacity, and speed.

#win32_physical memory - represents physical memory available t othe OS
#create a variable for totalcapacity, starting with a value of zero to be added onto later
$totalcapacity = 0
get-wmiobject -class win32_physicalmemory |
foreach {
            New-Object -TypeName psobject -Property @{
                Manufacturer=$_.manufacturer
                "Speed(Mhz)"=$_.speed
                #convert capacity to megabytes
                "Size(MB)"=$_.capacity/1mb
                Bank=$_.banklabel
                Slot=$_.devicelocator
        }
        #if there are multiple sticks of ram, add together all the capacities in megabytes
        $totalcapacity+=$_.capacity/1mb
}|
#format the information into a table and order the properties accordingly
ft -auto Manufacturer, "Size(MB)","Speed(MHz)",Bank,Slot
#create a string object to display the totalcapacity variable
"Total RAM: ${totalcapacity}MB" 
#################################################################################################################################
"+---------------------+"
"| Network Connections |"
"+---------------------+"
#6.	Display the ethernet interfaces(s) name, MAC address, and speed in Mbits/sec, assigned ip address and netmask, 
#   default gateway, dns domain, dns hostname, and dnssearchorder. Only include ipenabled interfaces.

#_networkadapter - represents a network adapter of a computer running a Windows OS
#_networkadapterconfiguration - represents TCP/IP methods and properties independent from adapter (more than networkadapter)
#the two will be "joined" with ".GetRelated()"

#create a variable for the ipv4 address
$ip=get-WmiObject Win32_NetworkAdapterConfiguration|Where {$_.Ipaddress.length -gt 1}

#start by retrieving properties from win32_networkadapter
Get-WmiObject Win32_NetworkAdapter  | 
#find only matching "Local Area Connection" in the NetconnectionID property
? NetconnectionID -match "Local Area Connection" |

Foreach-Object{
    #WMI Objects have a GetRelated() method used to find other WMI class objects for the same device
    #In this case, we are using Win32_networkadapterconfiguration
    $nac = @($_.GetRelated('Win32_NetworkAdapterConfiguration'))[0]
    #create custom object
    New-Object PSObject -Property @{
        Name=$_.servicename
        "Speed(Mb/s)"=$_.speed/1MB * 8 -as [int]
        #grab the first ipv4 address
        #because I searched for LAN, this won't be an issue
        IPAddress = $ip.ipaddress[0]
        #anything with "$nac" is coming from adapterconfiguration
        MACAddress = $nac.MACAddress
        SubnetMask = $nac.IPSubnet
        DefaultGateway = $nac.DefaultIPGateway
        #Note: Domain returns blank even though correct property was used
        DNSDomain = $nac.DNSDomain
        DNSHostname = $nac.DNSHostName
        NetconnectionID = $_.NetconnectionID
        Adaptertype = $_.adaptertype
    }
}|
Format-Table Name, MACAddress, "Speed(Mb/s)", IPAddress, SubnetMask, DefaultGateway, DNSDomain, DNSHostname 
#################################################################################################################################
"+------------+"
"| Disk Usage |"
"+------------+"
#7.	Display the mounted filesystems similar to the UNIX df command, showing the drive name, size of the filesystem in GB, 
#   free space in GB, free space percentage, and the share name if it is a network drive. 
#   Drives that have no filesystem, such as a CDROM device with no disk in it are omitted.

gwmi -class win32_logicaldisk |
#only grab drives with size
? size |
#extract properties from object "deviceid"
Select-Object deviceid,
    #hash elements
    #grab the size, convert it to gigabytes, and express as integer
    @{n="Size(GB)";e={$_.size/1gb -as [int]}},
    @{n="Free(GB)";e={$_.freespace/1gb -as [int]}},
    @{n="% Free(GB)";e={100 * $_.freespace/$_.size -as [int]}},
    @{n="Provider";e={$_.providername}}|
ft -AutoSize 
#################################################################################################################################
"+---------------------+"
"| Configured Printers |"
"+---------------------+"
#8.	Display a table of printers configured on the system showing the printer name, whether it is shared, 
#   whether it is the default printer, and the current status of the printer. Display the status, default, and shared information in English, not as codes.

#represents devices able to print to paper or files such as pdf
Get-WmiObject -Class Win32_Printer |
    Select-Object Name, 
                                       #if the value is 4 - "default"
                    @{n="Default?";e={ if($_.Attributes -band 4) {
                                            $mydefaultbit="default" 
                                        }
                                        $mydefaultbit
                                     }
                  },
                  
                                        #if the value is 8 - "shared"
                    @{n="Shared?";e={ if($_.Attributes -band 8) {
                                            $mydefaultbit="shared" 
                                        }
                                        $mydefaultbit
                                     }
                  },
                                    #switch used for testing if you are executing one more script blocks out of a group based on a value
                                                              #matching values with the human-readable status found on technet
                    @{n="Status";e={switch($_.printerstatus) {1 {$mystatus="other"}
                                                              2 {$mystatus="unknown"}
                                                              3 {$mystatus="idle"}
                                                              4 {$mystatus="printing"}
                                                              5 {$mystatus="warming up"}
                                                              6 {$mystatus="stopped printing"}
                                                              7 {$mystatus="offline"}
                                                        #if the status is not one of the above values, let the user know it's bad
                                                        default {$mystatus="BAD STATUS"}

                                                            }
                                        $mystatus
                                 }
                }|
    Format-Table Name, Shared?, Default?, Status  -AutoSize 
#################################################################################################################################
"+--------------------+"
"| Installed Software |"
"+--------------------+"
#9.	Display a table of the installed software products showing the install date, vendor name, 
#   and software product name. Sort the producst by installation date, then by vendor, then by product name.

"+-----------------------+"
"|Sorted by Install Date |"
"+-----------------------+"
gwmi -class win32_product |
Select-Object name,
                                #insert "/" to make the date more read-able
    @{n="Date";e={$_.installdate.insert(4,"/").insert(7,"/")}},
    @{n="Vendor";e={$_.vendor}}|
    #sort on the property "date"
    Sort-Object Date|
    ft -AutoSize 
#repeat for each variation of sorting
"+-----------------------+"
"|Sorted by Vendor       |"
"+-----------------------+"
gwmi -class win32_product |
Select-Object Name,
    
    @{n="Date";e={$_.installdate.insert(4,"/").insert(7,"/")}},
    @{n="Vendor";e={$_.vendor}}|
    Sort-Object Vendor|
ft -AutoSize 

"+-----------------------+"
"|Sorted by Product Name |"
"+-----------------------+"
gwmi -class win32_product |
Select-Object Name,
    
    @{n="Date";e={$_.installdate.insert(4,"/").insert(7,"/")}},
    @{n="Vendor";e={$_.vendor}}|
    Sort-Object Name|
ft -AutoSize 
#################################################################################################################################

