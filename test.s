		.section	.data
hello:		.string		"hello\nhello\n"
mello:		.string		"mello\nmello\n"
erase:		.ascii		"\033[2J"

		.section	.text
		.global		main
main:
		mov		x0, #1
		adr		x1, hello
		mov		x2, #12
		mov		x8, #64
		svc		0

		mov		x0, #1
		adr		x1, erase
		mov		x2, #4
		mov		x8, #64
		svc		0

		mov		x0, #0
		mov		x8, #93
		svc		0
