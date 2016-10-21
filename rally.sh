#! /bin/sh

if (( $# == 0 )); then
cat <<EOF
A script to simplify access to Rally user stories, tasks and defects.
By Demid Merzlyakov.

Usage:
	rally [-u|-t|-d] NUMBERS
	rally CODES

Options:
	-u|--userstory      NUMBERS are user story numbers.
	-t|--task           NUMBERS are tasks numbers.
	-d|--defect         NUMBERS are defects numbers.
	CODES               CODES are codes in form 'US1234', 'DE456', 'ta789' (case insensitive)

Examples:
	rally -d 123 456    # open defects DE123 DE456
	rally DE123 US456   # open defect DE123 and user story US456

You can add these lines to your .profile/.bash_profile to create shortcats:
	alias rally='/path/to/script/here/rally.sh'
	alias us='rally -u'
	alias ta='rally -t'
	alias de='rally -d'
To update an already-running terminal session, run
	source ~/.profile
EOF
else
	OPEN_USERSTORIES=false
	OPEN_TASKS=false
	OPEN_DEFECTS=false

	case $1 in
		-u|--userstory)
		OPEN_USERSTORIES=true
		shift # past argument
		;;
		-t|--task)
		OPEN_TASKS=true
		shift # past argument
		;;
		-d|--defect)
		OPEN_DEFECTS=true
		shift # past argument
		;;
	esac

	for i in $*; do
		BASE_SEARCH_URL="https://rally1.rallydev.com/#/search?keywords="
		SEARCH_REQUEST="$i"

		if $OPEN_USERSTORIES; then
			SEARCH_REQUEST="US$i"
		elif $OPEN_TASKS; then
			SEARCH_REQUEST="TA$i"
		elif $OPEN_DEFECTS; then
			SEARCH_REQUEST="DE$i"
		fi
		open "$BASE_SEARCH_URL$SEARCH_REQUEST"
	done;
fi
