; size_t	ft_strlen(const char *s);
; The strlen() function calculates the length of the string pointed to by s, excluding the terminating null byte ('\0').

section .text
global ft_strlen

ft_strlen:
	mov rdi, rdi	; String (passed as first argument)
	ret