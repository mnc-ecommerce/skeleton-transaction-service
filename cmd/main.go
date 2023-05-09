package main

import (
	"am-promo-svc/internal/server"
	"am-promo-svc/pkg/repositories"
	"context"
	"fmt"
	"github.com/jackc/pgx/v5"
	"log"
	"os"
	"os/signal"
	"syscall"
)

func main() {
	connect, err := pgx.Connect(context.Background(), "postgres://supa_trade:f540f084dd63311c@trade-677d363c.cmlw7vult9qi.ap-southeast-1.rds.amazonaws.com:5432/promotion-transaction")
	if err != nil {
		return
	}
	defer connect.Close(context.Background())
	repositoriesConnection := repositories.New(connect)

	app := server.SetupServer()
	server.CreateRoute(app, repositoriesConnection)

	// Listen from a different goroutine
	go func() {
		if err := app.Listen(":8080"); err != nil {
			log.Panic(err)
		}
	}()

	c := make(chan os.Signal, 1)                    // Create channel to signify a signal being sent
	signal.Notify(c, os.Interrupt, syscall.SIGTERM) // When an interrupt or termination signal is sent, notify the channel

	_ = <-c // This blocks the main thread until an interrupt is received
	fmt.Println("Gracefully shutting down...")
	_ = app.Shutdown()

	fmt.Println("Running cleanup tasks...")
	// Your cleanup tasks go here
	connect.Close(context.Background())
	// redisConn.Close()
	fmt.Println("Fiber was successful shutdown.")
}
