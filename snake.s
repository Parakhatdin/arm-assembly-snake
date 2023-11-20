		.section	.data
w_sharp:	.string		"#"
w_vline:	.string		"|"
w_gline:	.string		"_"
w_point:	.string		"."
w_erase:	.byte		0x7f
w_nl:		.string		"\n"
snake:	
		.space		1830

		.section	.text
		.global		main

// ---------------------------------------------
// main
// ---------------------------------------------
main:		
		stp	x29, x30, [sp, #-16]!
		mov	w0, #15
		mov	w1, #15
		adr	x2, snake
		stp	w0, w1, [x2]

		bl	draw

main_x:	
		ldp	x29, x30, [sp], #16
		ret

// ---------------------------------------------
// draw
// ---------------------------------------------
draw:
		stp	x29, x30, [sp, #-16]!
		mov	x5, #30
draw_l1:	
		cmp	x5, #0
		beq	draw_l1_x

		mov	x6, #60
draw_l2:
		cmp	x6, #0
		beq	draw_l2_x

draw_if1:	
		cmp	x5, #30
		bne	draw_if1_el
		bl	p_gline
		b	draw_if1_x
draw_if1_el:	
draw_if2:
		cmp	x5, #1
		bne	draw_if2_el
		bl	p_gline
		b	draw_if2_x
draw_if2_el:
draw_if3:
		cmp	x6, #60
		bne	draw_if3_el
		bl	p_vline
		b	draw_if3_x
draw_if3_el:
draw_if4:
		cmp	x6, #1
		bne	draw_if4_el
		bl	p_vline
		b	draw_if4_x
draw_if4_el:
		stp	x5, x6, [sp, #-16]!
		bl	hass
		ldp	x5, x6, [sp], #16
draw_if5:
		cmp	x0, #1
		bne	draw_if5_el
		bl	p_sharp
		b	draw_if5_x
draw_if5_el:
		bl	p_point
draw_if5_x:
draw_if4_x:
draw_if3_x:
draw_if2_x:
draw_if1_x:

		sub	x6, x6, #1
		b	draw_l2
draw_l2_x:
		bl	p_nl


		sub	x5, x5, #1
		b	draw_l1
draw_l1_x:	
draw_x:
		bl	p_erase
		ldp	x29, x30, [sp], #16
		ret

hass:
		stp	x29, x30, [sp, #-16]!
		mov	x4, #0
hass_l:	
		cmp	x4, #1830 
		beq	hass_l_x

		adr	x0, snake
		add	x0, x0, x4
		ldr	w1, [x0]
		ldr	w2, [x0, #4]
		
hass_if1:	
		cmp	w1, w5
		bne	hass_no
		cmp	w2, w6
		bne	hass_no
		b	hass_yes


		add	x4, x4, #1
		b	hass_l
hass_l_x:

hass_yes:
		mov	x0, #1
		b	hass_x
hass_no:
		mov	x0, #0
		b	hass_x
hass_x:
		ldp	x29, x30, [sp], #16
		ret
		

p_sharp:	
		mov	x0, #1
		adr	x1, w_sharp
		mov	x2, #1
		mov	x8, #64
		svc	0
		ret

p_vline:	
		mov	x0, #1
		adr	x1, w_vline
		mov	x2, #1
		mov	x8, #64
		svc	0
		ret
p_gline:	
		mov	x0, #1
		adr	x1, w_gline
		mov	x2, #1
		mov	x8, #64
		svc	0
		ret
p_point:	
		mov	x0, #1
		adr	x1, w_point
		mov	x2, #1
		mov	x8, #64
		svc	0
		ret
p_nl:	
		mov	x0, #1
		adr	x1, w_nl
		mov	x2, #1
		mov	x8, #64
		svc	0
		ret
p_erase:
		stp	x29, x30, [sp, #-16]!
		mov	x3, #1830
p_erase_l:
		cmp	x3, #0
		beq	p_erase_l_x
		mov	x0, #1
		adr	x1, w_erase
		mov	x2, #1
		mov	x8, #64
		svc	0
		sub	x3, x3, #1
		b	p_erase_l
p_erase_l_x:
p_erase_x:
		ldp	x29, x30, [sp], #16
		ret

