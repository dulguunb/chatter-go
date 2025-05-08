package logging

import (
	"fmt"
	"os"

	"github.com/google/uuid"
	"go.uber.org/zap"
	"go.uber.org/zap/zapcore"
)

var Logger *zap.Logger

func init() {
	logUuid := uuid.NewString()
	// Open the log file
	file, err := os.OpenFile(fmt.Sprintf("app-%s.log", logUuid), os.O_CREATE|os.O_APPEND|os.O_WRONLY, 0644)
	if err != nil {
		panic(err)
	}

	// Encoder configuration
	encoderCfg := zap.NewProductionEncoderConfig()
	encoderCfg.TimeKey = "timestamp"
	encoderCfg.EncodeTime = zapcore.ISO8601TimeEncoder
	encoderCfg.EncodeLevel = zapcore.CapitalLevelEncoder

	// Create encoders
	fileEncoder := zapcore.NewJSONEncoder(encoderCfg)
	// consoleEncoder := zapcore.NewConsoleEncoder(encoderCfg)

	// Define write syncers
	fileWriter := zapcore.AddSync(file)
	// consoleWriter := zapcore.AddSync(os.Stdout)

	// Combine both cores
	core := zapcore.NewTee(
		zapcore.NewCore(fileEncoder, fileWriter, zapcore.InfoLevel),
		zapcore.NewCore(fileEncoder, fileWriter, zapcore.FatalLevel),
		zapcore.NewCore(fileEncoder, fileWriter, zapcore.ErrorLevel),
		zapcore.NewCore(fileEncoder, fileWriter, zapcore.DebugLevel),
		// zapcore.NewCore(consoleEncoder, consoleWriter, logLevel),
	)

	// Create the logger
	Logger = zap.New(core, zap.AddCaller())
}
