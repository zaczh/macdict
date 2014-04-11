EXECUTABLE = macdict

c: $(EXECUTABLE).c
	@clang -o $(EXECUTABLE) -framework CoreServices $< && chmod +x $(EXECUTABLE)

m: $(EXECUTABLE).m
	@clang -o $(EXECUTABLE) -framework CoreServices -framework Foundation $< \
		&& chmod +x $(EXECUTABLE)

sh: $(EXECUTABLE).sh
	@cp $< $(EXECUTABLE) && chmod +x $(EXECUTABLE)

py: $(EXECUTABLE).py
	@cp $< $(EXECUTABLE) && chmod +x $(EXECUTABLE)

clean:
	rm $(EXECUTABLE)

.PHONY: clean