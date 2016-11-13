if (TARGET vanilla_library)
	message("Skipping target `vanilla_library` as it is included by a parent.")
else()
	add_subdirectory(vanilla_library)
endif()

if (TARGET catch)
	message("Skipping target `catch` as it is included by a parent.")
else()
	add_subdirectory(catch)
endif()





