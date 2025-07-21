import { Clarinet, Tx, Chain, Account, types } from 'https://deno.land/x/clarinet@v1.5.4/index.ts';
import { assertEquals } from 'https://deno.land/std@0.170.0/testing/asserts.ts';

Clarinet.test({
    name: "Channel Closed: Create Challenge Tests",
    async fn(chain: Chain, accounts: Map<string, Account>) {
        const deployer = accounts.get('deployer')!;
        const creator = accounts.get('wallet_1')!;

        // Test successful challenge creation
        let block = chain.mineBlock([
            Tx.contractCall('channel-closed', 'create-challenge', [
                types.ascii('Summer Writing Sprint'),
                types.utf8('Craft a captivating summer story'),
                types.ascii('fiction'),
                types.uint(43200),
                types.uint(43200),
                types.uint(100000),
                types.uint(1000000)
            ], creator.address)
        ]);

        // Assert successful challenge creation
        assertEquals(block.receipts[0].result.expectOk(), 'u1');
    }
});

Clarinet.test({
    name: "Channel Closed: Submit Work Tests",
    async fn(chain: Chain, accounts: Map<string, Account>) {
        const creator = accounts.get('wallet_1')!;
        const author = accounts.get('wallet_2')!;

        // Create challenge first
        let createBlock = chain.mineBlock([
            Tx.contractCall('channel-closed', 'create-challenge', [
                types.ascii('Summer Stories'),
                types.utf8('Summer themed writing challenge'),
                types.ascii('fiction'),
                types.uint(43200),
                types.uint(43200),
                types.uint(100000),
                types.uint(1000000)
            ], creator.address)
        ]);

        // Submit work to challenge
        let submitBlock = chain.mineBlock([
            Tx.contractCall('channel-closed', 'submit-work', [
                types.uint(1),
                types.ascii('Ocean Memories'),
                types.buff(Buffer.from('test-hash', 'utf8'))
            ], author.address)
        ]);

        // Assert successful work submission
        assertEquals(submitBlock.receipts[0].result.expectOk(), 'u1');
    }
});