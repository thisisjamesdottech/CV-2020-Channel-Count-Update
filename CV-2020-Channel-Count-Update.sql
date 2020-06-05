/*
Name:       CV 2020 Channel Count Update
Purpose:    This script corrects the channel count for VMS devices on a proxy server within the CompleteView 2020 Desktop Client
Author:     James Anderson
Date:       20Apr2020
Version:    1.2
Comments:   N/A

Version History:
 -  :    (03Mar2020)  1.0 Initial build of Channel Count update functionality of script
 -  :    (20Apr2020)  1.1 Addition of DriverType portion of code
 */

/*
The following updates the channel count for a specified VMS device on a proxy server, using multiple UPDATE SET statements as we cannot have more than one SET with a specific number value per UPDATE. 

The overall syntax in use is as follows:

UPDATE CompleteView.dbo.VideoDevices
SET ChannelCount = <n> WHERE IpAddressV4 IN '(<example1>','<example2>','<example3>')
*/

UPDATE CompleteView.dbo.VideoDevices
SET ChannelCount = 2 WHERE IpAddressV4 IN ('DEVICE1','DEVICE2','DEVICE3')
UPDATE CompleteView.dbo.VideoDevices
SET ChannelCount = 3 WHERE IpAddressV4 IN ('DEVICE4','DEVICE5','DEVICE6')
UPDATE CompleteView.dbo.VideoDevices
SET ChannelCount = 4 WHERE IpAddressV4 IN ('DEVICE7','DEVICE8')
UPDATE CompleteView.dbo.VideoDevices
SET ChannelCount = 7 WHERE IpAddressV4 = 'DEVICE9'
UPDATE CompleteView.dbo.VideoDevices
SET ChannelCount = 9 WHERE IpAddressV4 = 'DEVICE10'

-- The following code is used to view the new channel counts after executing the above, and can be included consecutively with the above SQL code

SELECT IpAddressV4,ChannelCount
FROM CompleteView.dbo.VideoDevices
WHERE IpAddressV4 IN ('DEVICE1','DEVICE2','DEVICE3','DEVICE4','DEVICE5','DEVICE6','DEVICE7','DEVICE8','DEVICE9','DEVICE10')

/*
It was determined that we must also change the DriverType value to 11 as per the software's defined field/value pairs in relation to the VMS device counts being changed
(This lets the CompleteView 2020 software know that these devices are multi-channel)
*/

UPDATE CompleteView.dbo.Device
SET DriverType = 11
FROM Device d
	INNER JOIN CompleteView.dbo.VideoDevices v ON d.DeviceRelationId=v.VideoDeviceId
WHERE IpAddressV4 IN ('DEVICE1','DEVICE2','DEVICE3','DEVICE4','DEVICE5','DEVICE6','DEVICE7','DEVICE8','DEVICE9','DEVICE10')


-- The following code is used to view the changes made in the script above

SELECT DriverType, IpAddressV4
FROM CompleteView.dbo.Device d
INNER JOIN CompleteView.dbo.VideoDevices v ON d.DeviceRelationId=v.VideoDeviceId
WHERE IpAddressV4 IN ('DEVICE1','DEVICE2','DEVICE3','DEVICE4','DEVICE5','DEVICE6','DEVICE7','DEVICE8','DEVICE9','DEVICE10','DEVICE11','DEVICE12','DEVICE13','DEVICE14')

-- Consolidated one-shot example for a single server
-- Use IN ('value1','value2') for multiple

UPDATE CompleteView.dbo.VideoDevices
SET ChannelCount = 7 WHERE IpAddressV4 = 'DEVICE1'
UPDATE CompleteView.dbo.Device
SET DriverType = 11
FROM Device d
	INNER JOIN CompleteView.dbo.VideoDevices v ON d.DeviceRelationId=v.VideoDeviceId
WHERE IpAddressV4 = 'DEVICE1'
SELECT DriverType, IpAddressV4, ChannelCount
FROM CompleteView.dbo.Device d
INNER JOIN CompleteView.dbo.VideoDevices v ON d.DeviceRelationId=v.VideoDeviceId
WHERE IpAddressV4 = 'DEVICE1'