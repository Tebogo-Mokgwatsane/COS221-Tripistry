<?php
require_once '../auth.php';
requireRole('traveller');
?>
<!DOCTYPE html>
<html>
    <head>
        <title>Tripistry Payment</title>
        <link rel="stylesheet" href="../css/payment.css">
    </head>
    <body>
        <h1>Package Payment</h1><br>
        <div>
            <form class="paymentForm">
                <div class="form-group">
                    <label for="paymentMethod">Payment Method:</label>
                    <div id="paymentMethod">
                        <input type="radio" id="creditCard" name="method" value="Credit Card">
                        <label for="creditCard">Credit Card</label>

                        <input type="radio" id="debitCard" name="method" value="Debit Card">
                        <label for="debitCard">Debit Card</label>

                        <input type="radio" id="cash" name="method" value="Cash">
                        <label for="cash">Cash</label>

                        <input type="radio" id="eft" name="method" value="EFT">
                        <label for="eft">EFT</label>

                        <input type="radio" id="paypal" name="method" value="Paypal">
                        <label for="paypal">Paypal</label>
                    </div>
                </div>
                <br>
                <div class="form-group">
                    <label for="reference">Payment Reference:</label>
                    <input type="text" id="reference" placeholder="PAY-001" required>
                </div>
                <br>
                <button type="submit">Confirm</button>
            </form>
        </div>
        <br>
        <button onclick="history.back()">Back</button></a>
        <p id="response"></p>
    </body>
    <script src="../scripts/payment.js"></script>
</html>