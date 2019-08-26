# paths file a la https://github.com/zoey-rw/NEFI_microbe/blob/master/paths.r

# get host name
host <- system('hostname', intern=T)
#print(host)

# # define NEON_data folder relative to host name
# if (host == 'dhcp-wifi-8021x-155-41-55-236.bu.edu') {
if (substr(host, 1, 15) == "dhcp-wifi-8021x") {
  NEON_data <- '/Users/BrianaHackos/RProjects/NEON_data/'
} else if (host == 'scc1') {
  NEON_data <- '/usr4/spclpgm/bhackos/NEON_data/'
  } else cat("hostname doesn't exist, where are you running this??")

# #make directory if it doesn't exist
cmd <- paste0('mkdir -p ', NEON_data)
system(cmd)


# Individual filepaths
# N-cycle data
N_data_path <- paste0(NEON_data, "N_data_path.rds")

meta_data_path <- paste0(NEON_data, "meta_data_path.rds")

