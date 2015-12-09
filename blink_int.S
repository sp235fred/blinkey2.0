#include <avr/io.h>
	
	.section	.text
	
	.global doit
doit:
	sbi	_SFR_IO_ADDR(DDRB), DDB0
	sbi	_SFR_IO_ADDR(DDRD), DDD6
	sbi 	_SFR_IO_ADDR(PORTB), PORTB0
	cbi	_SFR_IO_ADDR(PORTD), PORTD6
	ldi	r16, (0<<CS12)|(1<<CS11)|(1<<CS10)
	sts	TCCR1B, r16
	ldi	r16, (1<<TOIE1)
	sts	TIMSK1, r16
	clr	r16
	sts	TCNT1H, r16
	sts	TCNT1L, r16
	sei
forever:
	cpi		ch, '0'
	breq	off
	cpi		ch, '1'
	breq	normalSpeed
	cpi		ch, '2'
	breq	doubleSpeed
	rjmp forever
off:
	in    r16, _SFR_IO_ADDR(SREG)
  	push  r16
	ldi   r16, 0x00
	sts   TCNT1H, r16
  	sts   TCNT1L, r16
  	pop   r16
	out   _SFR_IO_ADDR(SREG), r16
 	rjmp  forever
normalSpeed:
	in    r16, _SFR_IO_ADDR(SREG)
  	push  r16
  	ldi   r16, 0x00
  	sts   TCNT1H, r16
	sts   TCNT1L, r16
  	sts   ch, 3
  	pop   r16
  	out   _SFR_IO_ADDR(SREG), r16
  	rjmp  forever
doubleSpeed:
	 in    r16, _SFR_IO_ADDR(SREG)
  	push  r16
	ldi   r16, 0x80
  	sts   TCNT1H, r16
  	ldi   r16, 0x00
  	sts   TCNT1L, r16
  	sts   ch, 3
  	pop   r16
  	out   _SFR_IO_ADDR(SREG), r16
  	rjmp  forever

	.global TIMER1_OVF_vect
TIMER1_OVF_vect:
	in	r2, _SFR_IO_ADDR(SREG)
	push	r2
	sbi	_SFR_IO_ADDR(PINB), PINB0
	sbi	_SFR_IO_ADDR(PIND), PIND6
	sbis	_SFR_IO_ADDR(PINB), PINB0
	ldi	r16, 'A'
	sbis	_SFR_IO_ADDR(PIND), PIND6
	ldi	r16, 'B'
	call 	usart_send
	pop	r2
	out	_SFR_IO_ADDR(SREG), r2
	reti

	.end
