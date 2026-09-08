import { createStore } from './vendor/zustand-vanilla.mjs';
import { withDevtoolsBridge } from './vendor/bridge.js';
// Public demo data only. Real applications should use a development-only flag.
const promotion = createStore(withDevtoolsBridge(set => ({
  discount: 0,
  apply: () => set({ discount: 0.1 }, false, 'promotion/applyTenPercent'),
  reset: () => set({ discount: 0 }, false, 'promotion/reset'),
}), { name: 'demo-promotion', enabled: true }));
const cart = createStore(withDevtoolsBridge((set, get) => ({
  quantity: 1, unitPrice: 30, total: 30,
  add: () => set(s => ({ quantity: s.quantity + 1, total: (s.quantity + 1) * s.unitPrice * (1 - promotion.getState().discount) }), false, 'cart/addLamp'),
  applyDiscountBug: () => set({ total: get().unitPrice * (1 - promotion.getState().discount) }, false, 'cart/applyDiscountBug'),
  correct: () => set(s => ({ total: s.quantity * s.unitPrice * (1 - promotion.getState().discount) }), false, 'cart/correctDiscount'),
  reset: () => set({ quantity: 1, total: 30 }, false, 'cart/reset'),
}), { name: 'demo-cart', enabled: true }));
const money = n => new Intl.NumberFormat('en-IE', { style: 'currency', currency: 'EUR' }).format(n);
function render() {
  const { quantity, total, unitPrice } = cart.getState();
  const { discount } = promotion.getState();
  const expected = quantity * unitPrice * (1 - discount);
  document.getElementById('quantity').textContent = quantity;
  document.getElementById('discount').textContent = `${discount * 100}%`;
  document.getElementById('total').textContent = money(total);
  document.getElementById('outcome').textContent = Math.abs(total - expected) > 0.001
    ? `Bug reproduced: ${money(total)} shown; ${money(expected)} expected for ${quantity} lamps. Inspect cart/applyDiscountBug.`
    : discount ? `Total matches: ${money(total)} for ${quantity} lamp${quantity === 1 ? '' : 's'}.` : 'Add a second lamp, then apply the discount.';
}
cart.subscribe(render); promotion.subscribe(render);
document.getElementById('add').addEventListener('click', () => cart.getState().add());
document.getElementById('coupon').addEventListener('click', () => { promotion.getState().apply(); cart.getState().applyDiscountBug(); });
document.getElementById('fix').addEventListener('click', () => cart.getState().correct());
document.getElementById('reset').addEventListener('click', () => { promotion.getState().reset(); cart.getState().reset(); });
render();
