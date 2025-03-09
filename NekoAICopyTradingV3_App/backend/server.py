from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
from typing import List

app = FastAPI()

class TradingSignal(BaseModel):
    id: int
    symbol: str
    signal_type: str
    confidence: float
    tp: float
    sl: float

class ActiveTrade(BaseModel):
    id: int
    symbol: str
    entry_price: float
    current_price: float
    tp: float
    sl: float
    status: str

trading_signals = []  # Placeholder for trading signals
active_trades = []    # Placeholder for active trades

@app.get("/")
def read_root():
    return {"Hello": "World"}

@app.get("/signals", response_model=List[TradingSignal])
def get_signals():
    if not trading_signals:
        raise HTTPException(status_code=404, detail="No trading signals available")
    return trading_signals

@app.get("/trades", response_model=List[ActiveTrade])
def get_trades():
    if not active_trades:
        raise HTTPException(status_code=404, detail="No active trades available")
    return active_trades

@app.post("/trades/update", response_model=ActiveTrade)
def update_trade(trade: ActiveTrade):
    for t in active_trades:
        if t.id == trade.id:
            t.tp = trade.tp
            t.sl = trade.sl
            return t
    raise HTTPException(status_code=404, detail="Trade not found")

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="127.0.0.1", port=5000)

app = FastAPI()

@app.get("/")
def read_root():
    return {"Hello": "World"}

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="127.0.0.1", port=5000)
