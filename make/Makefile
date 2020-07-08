# Cheatsheets:
# https://gist.github.com/tuannvm/c0dcf6bd052d5607fff040c235103928
# https://devhints.io/makefile

# Hints:
# @ - Don't print command, but commands are the same
# $ - Magics of a Makefile, or invoking something

# $info()/@echo - Pretty much the same, info is a Make call 
# while echo is a shell call

.PHONY: outer_variables local_variables
simple_string = '10' # Regular assignment
simple_temp := 30 # Immediate assignment
simple_safe ?= 30 # safe assignment
simple_apend += '30' # Appending
TEMP_VAR=3

global_variables: 
	# This not prints "echo" inside the print
	@echo $(simple_string) # Variable echoed with Makefile magic
	# This will print the echo as well
	echo $(simple_string)
	# Simple string
	@echo Simple string is $(simple_string)
	# Simple temp
	@echo Simple temp is $(simple_temp)
	@cat /tmp/david

local_variables:
	$(eval local_variable := '20')
	local_variable='10' # Won't work - it's a local variable
	@echo Local variable is $(local_variable) 
	@echo Local variable is ${local_variable} 
	TEMP_VAR=10 # Can't change variable
	@echo Temp Var is ${TEMP_VAR} 
	@echo Temp Var is $(TEMP_VAR) 

invoking_cmds:
	# When invoking w/ $ - run in a different shell
	# When invoking w/o $ - run in a same shell

	# Example of failing the CMD
	# bash -c "exit 2"

	# Running it in a differnt shell - examples
	$(bash -c "exit 4")
	$(shell -c python3.6 /tmp/omriko.py)
	@echo Return code is ${$?}

	# If we'll do EXIT_CODE with $() when running it 

	# Exit code won't work snce it's defined localy
	EXIT_CODE=10
	@echo Exit code is $(EXIT_CODE)
