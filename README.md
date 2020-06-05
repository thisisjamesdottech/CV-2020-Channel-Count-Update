# CV-2020-Channel-Count-Update
 This script corrects the channel count for cameras on a proxy server within the CompleteView 2020 Desktop Client.

 The use case for this script was a client with multiple remote recording servers utilizing proxy servers as an in-between setup on their WAN so users not locally on-site with the servers may also view the camera footage, both live and video playback.

 Where a normal server would consist of one server with n number of cameras, the proxy server would be one proxy server with n number of servers, the servers being listed not as a camera but instead as a "VMS device." They would, however, still utilize the camera section of the GUI, with the number of cameras on the physical server being represented by the number of channels associated with the VMS device.

 As this client has 400+ servers with 15000+ cameras, the ability to manage the proxy servers via SQL was exceptionally more efficient versus utilizing the Desktop Client GUI.